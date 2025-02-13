import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:test/constants.dart';
import 'package:test/models/database.dart';
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
          "${e.timestamp.month}/${e.timestamp.day}/${e.timestamp.year}";
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
      String consolidatedDataString = "";
      double totalWeight = 0;
      String unit = "lbs.";
      listOfSets.forEach((element) {
        switch (element.equipmentType) {
          // aggregation logic works differently based on equipment type
          case "barbell":
            totalWeight += element.weight * element.nOfReps;
          case EQUIPMENTTYPE_DUMBBELL:
            // double the weight before aggregating since each arm does the same weight
            totalWeight += element.weight * element.nOfReps * 2;
          case EQUIPMENTTYPE_BODYWEIGHT:
            // simply add the reps instead of the weight
            totalWeight += element.nOfReps;
            unit = "reps";
          default:
            break;
        }
        consolidatedDataString +=
            "${element.weight} lbs. (${element.equipmentType}) x${element.nOfReps} reps\n";
      });
      rows.add(TableRow(children: [
        Center(child: Text(date.toString())),
        Center(child: Text(listOfSets[0].movement)),
        Center(child: Text("$totalWeight $unit")),
        Center(child: Text(consolidatedDataString)),
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
          Text('View Workouts by Exercise'),
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
            border: TableBorder.all(color: Colors.deepOrange),
            children: [
              TableRow(children: [
                Center(child: Text('Date')),
                Center(child: Text('Movement')),
                Center(child: Text('Total Weight Moved')),
                Center(child: Text('Consolidated Data')),
              ]),
              ...makeRemainingRows(),
            ],
          ),
        ],
      ),
    );
  }
}
