import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:test/constants.dart';
import 'package:test/models/database.dart';
import 'package:test/shared/form_input_validator.dart';

import 'package:drift/drift.dart' as drift;

class VisualizerWidget extends StatefulWidget {
  final AppDatabase _db;

  VisualizerWidget(this._db, {Key? key}) : super(key: key);

  @override
  _VisualizerWidgetState createState() => _VisualizerWidgetState();
}

class _VisualizerWidgetState extends State<VisualizerWidget> {
  final _searchBarController = TextEditingController();
  List<MapEntry<DateTime, List<WeightliftingSetData>>> setsOrderedByDate = [];
  bool _showEditForm = false; // whether to show the edit form

  void aggregateDataByDate(Movement movement) async {
    /// fetch data from db and aggregate by date, sorting from most -> least recent

    var results = await (await widget._db.select(widget._db.weightliftingSet)
          ..where((e) => (e.movement.equals(movement.name))))
        .get();
    print("Found ${results.length} entries for ${movement.name}: \n$results");

    final byDate = Map<DateTime, List<WeightliftingSetData>>();
    results.forEach((e) {
      // aggregate sets by date performed
      print(e);
      final ts = e.timestamp;
      final date = DateTime(ts.year, ts.month, ts.day); // remove time data
      if (byDate.containsKey(date)) {
        byDate[date]!.add(e);
      } else {
        byDate[date] = [e];
      }
    });

    // order the sets by date performed from most -> least recent
    List<MapEntry<DateTime, List<WeightliftingSetData>>> listFromMap = [];
    byDate.forEach((ts, entry) {
      listFromMap.add(MapEntry(ts, entry));
    });
    listFromMap.sort((a, b) => b.key.compareTo(a.key));
    setsOrderedByDate = listFromMap;

    // convert to a list
    print(byDate);
    byDate.entries.toList().sort((a, b) => b.key.compareTo(a.key));
    print(byDate);

    byDate.forEach((timestamp, workoutData) {
      // order the individual sets for a given workout by timestamp (most -> least recent)
      workoutData.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });

    setState(() {});
  }

  Future updateEntry(AppDatabase db, int id, String movement, int nOfReps,
      double weight, String equipmentType) async {
    // update entry in db
    print(
        "Updating entry with id: $id & data = $movement | $nOfReps | $weight | $equipmentType");
    return await (db.update(db.weightliftingSet)
          ..where((entry) => entry.id.equals(id)))
        .write(WeightliftingSetCompanion(
      movement: drift.Value(movement),
      nOfReps: drift.Value(nOfReps),
      weight: drift.Value(weight),
      equipmentType: drift.Value(equipmentType),
    ));
  }

  Widget showEditForm(int id) {
    // when user taps on the button showing a set of data, show the edit form, indicating the id of the item to edit
    // want to reuse the same entry form, just with prepopulated data, so make that its own widget
    return Container();
  }

  List<TableRow> makeRemainingRows() {
    // creates rows using the byDate map
    List<TableRow> rows = [];
    setsOrderedByDate.forEach((entry) {
      DateTime timestamp = entry.key;
      List<WeightliftingSetData> listOfWorkoutSets = entry.value;

      int nOfReps = 0;
      List<String> dataForSet = [];
      double totalWeight = 0;
      String timeElapsed = "";
      int entryID = -1;
      String repsString = "";
      String weightString = "";
      EQUIPMENTTYPES.forEach((type) {
        switch (type) {
          case EQUIPMENTTYPE_BODYWEIGHT:
            // for bodyweight sets, display string showing aggregated reps
            nOfReps = listOfWorkoutSets
                .where((e) => (e.equipmentType == type))
                .fold<int>(nOfReps, (previous, element) {
              return (previous + element.nOfReps);
            });
            repsString = "$nOfReps reps";
          default:
            // for weighted sets, display string showing aggregated weight
            if (type == EQUIPMENTTYPE_DUMBBELL) {
              // double value for dumbbells since weight is in each hand
              print("dumbbell! total weight: $totalWeight");
              totalWeight = listOfWorkoutSets
                  .where((e) => (e.equipmentType == type))
                  .fold<double>(totalWeight, (previous, element) {
                print("previous: $previous | element: $element");
                return (previous + element.nOfReps * element.weight * 2);
              });
              print(totalWeight);
            } else {
              // default option, simply aggregate weight x reps
              print("not dumbbell, type: $type, weight: $totalWeight");
              totalWeight = listOfWorkoutSets
                  .where((e) => (e.equipmentType == type))
                  .fold<double>(totalWeight, (previous, element) {
                print("previous: $previous | element: $element");
                return (previous + element.weight * element.nOfReps);
              });
              print(totalWeight);
            }
            weightString = "${totalWeight.toStringAsFixed(2)} lbs";
        }
      });
      print("Total weight: $totalWeight | nOfReps: $nOfReps");

      listOfWorkoutSets.forEach((element) {
        entryID = element.id;
        int _td = listOfWorkoutSets.first.timestamp
            .difference(listOfWorkoutSets.last.timestamp)
            .inSeconds;
        timeElapsed = "${(_td / 60).floor()}m ${_td % 60}s";
        dataForSet.add(
            "${element.weight.toStringAsFixed(2)} lbs (${element.equipmentType}) x${element.nOfReps} reps");
      });

      rows.add(TableRow(children: [
        Center(
            child:
                Text("${timestamp.month}/${timestamp.day}/${timestamp.year}")),
        Center(child: Text(listOfWorkoutSets[0].movement)),
        Center(
            child: Text((totalWeight == 0)
                ? "$repsString in $timeElapsed"
                : (nOfReps == 0)
                    ? "$weightString in $timeElapsed"
                    : "$repsString + $weightString in $timeElapsed")),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: dataForSet
                .map((data) => TextButton(
                      child: Text(data),
                      style: TextButton.styleFrom(
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () => _showEditForm,
                    ))
                .toList(),
          ),
        ),
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
          (_showEditForm) ? showEditForm(1) : Container(),
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
                Center(child: Text('Total Weight Moved in Time')),
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
