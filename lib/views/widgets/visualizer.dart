import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:test/models/database.dart';
import 'package:test/models/tables.dart';
import 'package:test/shared/form_input_validator.dart';

class VisualizerWidget extends StatefulWidget {
  final AppDatabase _db;

  VisualizerWidget(this._db, {Key? key}) : super(key: key);

  @override
  _VisualizerWidgetState createState() => _VisualizerWidgetState();
}

class _VisualizerWidgetState extends State<VisualizerWidget> {
  final _searchBarController = TextEditingController();
  Map<String, List<WeightliftingSetData>> _byDate = {};

  void aggregateDataByDate(Movement movement) async {
    /// fetch data from db and aggregate by date

    var results = await (await widget._db.select(widget._db.weightliftingSet)
          ..where((e) => (e.movement.equals(movement.name))))
        .get();
    print("Found ${results.length} entries for ${movement.name}: \n$results");

    _byDate = Map<String, List<WeightliftingSetData>>();
    results.forEach((e) {
      // aggregate by date
      print(e);
      String date =
          "${e.timestamp.year}-${e.timestamp.month}-${e.timestamp.day}";
      if (_byDate.containsKey(date)) {
        _byDate[date]!.add(e);
      } else {
        _byDate[date] = [e];
      }
    });

    _byDate.forEach((key, value) {
      // order by timestamp (earliest to latest)
      value.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    });
    setState(() {
      // updates table
    });
  }

  List<TableRow> makeRemainingRows() {
    // creates rows using the byDate map
    List<TableRow> rows = [];
    _byDate.forEach((date, listOfSets) {
      String consolidatedData = "";
      listOfSets.forEach((element) {
        consolidatedData +=
            "${element.weight} lbs. (${element.equipmentType}) x${element.nOfReps} reps\n";
      });
      rows.add(TableRow(children: [
        Text(date.toString()),
        Text(listOfSets[0].movement),
        Text(consolidatedData),
      ]));
    });
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Quick View'),
          TypeAheadField<Movement>(
            controller: _searchBarController,
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                    hintText: "search by movement", icon: Icon(Icons.search)),
                validator: StringFormInputValidator().validateInput,
                onSaved: (String? value) {},
              );
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.name),
              );
            },
            onSelected: (value) {
              // fetch data for selection and load table
              _searchBarController.text = value.name;
              aggregateDataByDate(value);
            },
            suggestionsCallback: (input) async {
              if (input.isEmpty) {
                return null;
              }
              var results = await widget._db.select(widget._db.movements).get();
              return results
                  .where(
                      (e) => e.name.toLowerCase().contains(input.toLowerCase()))
                  .toList();
            },
            hideOnEmpty: true,
          ),
          Table(
            border: TableBorder.all(color: Colors.black),
            children: [
              TableRow(children: [
                Text('Date'),
                Text('Movement'),
                Text('Consolidated Data'),
              ]),
              ...makeRemainingRows(),
            ],
          ),
        ],
      ),
    );
  }
}
