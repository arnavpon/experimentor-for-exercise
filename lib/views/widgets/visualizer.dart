import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ExerciseMentor/constants.dart';
import 'package:ExerciseMentor/models/database.dart';
import 'package:ExerciseMentor/shared/form_input_validator.dart';

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
    var results = await (await widget._db.select(widget._db.weightliftingSet)
          ..where((e) => (e.movement.equals(movement.name))))
        .get();

    final byDate = Map<DateTime, List<WeightliftingSetData>>();
    results.forEach((e) {
      final ts = e.timestamp;
      final date = DateTime(ts.year, ts.month, ts.day); // remove time data
      if (byDate.containsKey(date)) {
        byDate[date]!.add(e);
      } else {
        byDate[date] = [e];
      }
    });

    // First sort the sets within each date
    byDate.forEach((timestamp, workoutData) {
      // Sort individual sets by timestamp (newest first)
      workoutData.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });

    // Then create the ordered map entries
    List<MapEntry<DateTime, List<WeightliftingSetData>>> listFromMap = [];
    byDate.forEach((ts, entry) {
      listFromMap.add(MapEntry(ts, entry));
    });

    // Sort by date (newest first)
    listFromMap.sort((a, b) => b.key.compareTo(a.key));

    setState(() {
      setsOrderedByDate = listFromMap;
    });
  }

  void _showEditDialog(
      BuildContext context, int id, WeightliftingSetData exercise) {
    // Controllers for the form fields, pre-populated with current values
    final TextEditingController movementController =
        TextEditingController(text: exercise.movement);
    final TextEditingController repsController =
        TextEditingController(text: exercise.nOfReps.toString());
    final TextEditingController weightController =
        TextEditingController(text: exercise.weight.toString());
    String selectedEquipmentType = exercise.equipmentType;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Exercise'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: movementController,
                  decoration: InputDecoration(labelText: 'Exercise Name'),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: repsController,
                  decoration: InputDecoration(labelText: 'Reps'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(labelText: 'Weight (lbs)'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedEquipmentType,
                  decoration: InputDecoration(labelText: 'Equipment Type'),
                  items: EQUIPMENTTYPES.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      selectedEquipmentType = value;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                try {
                  final movement = movementController.text;
                  final nOfReps = int.parse(repsController.text);
                  final weight = double.parse(weightController.text);

                  // Update the entry in the database
                  await AppDatabase.updateEntry(widget._db, id, movement,
                      nOfReps, weight, selectedEquipmentType);

                  // Close the dialog
                  Navigator.of(context).pop();

                  // Refresh the data display
                  if (setsOrderedByDate.isNotEmpty &&
                      setsOrderedByDate[0].value.isNotEmpty) {
                    final currentMovement = Movement(
                        id: 0, name: setsOrderedByDate[0].value[0].movement);
                    aggregateDataByDate(currentMovement);
                  }

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Exercise updated successfully')));
                } catch (e) {
                  // Show error for invalid inputs
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Please enter valid values for reps and weight')));
                }
              },
            ),
          ],
        );
      },
    );
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
              print("total weight: $totalWeight");
              totalWeight = listOfWorkoutSets
                  .where((e) => (e.equipmentType == type))
                  .fold<double>(totalWeight, (previous, element) {
                print("previous: $previous | element: $element");
                return (previous + element.nOfReps * element.weight * 2);
              });
              print(totalWeight);
            } else {
              // default option, simply aggregate weight x reps
              print("type: $type, weight: $totalWeight");
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

      List<WeightliftingSetData> sortedSets = List.from(listOfWorkoutSets);

      sortedSets.forEach((element) {
        entryID = element.id;
        int _td = sortedSets.first.timestamp
            .difference(sortedSets.last.timestamp)
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
            children: List.generate(dataForSet.length, (index) {
              return TextButton(
                child: Text(dataForSet[index]),
                style: TextButton.styleFrom(
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  _showEditDialog(
                      context, sortedSets[index].id, sortedSets[index]);
                },
              );
            }),
          ),
        ),
      ]));
    });
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Keep search section at the top (fixed)
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

        // Make the table portion scrollable
        Expanded(
          child: SingleChildScrollView(
            child: Table(
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
          ),
        ),
      ],
    );
  }
}
