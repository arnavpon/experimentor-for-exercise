import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:test/models/database.dart';
import '../../shared/useful_string_extensions.dart';

// Shows salient information for the ongoing workout (if one is taking place) or the most recent workout

class WorkoutSummaryWidget extends StatefulWidget {
  final AppDatabase _db;
  const WorkoutSummaryWidget(this._db, {Key? key}) : super(key: key);

  @override
  _WorkoutSummaryWidgetState createState() => _WorkoutSummaryWidgetState();
}

class _WorkoutSummaryWidgetState extends State<WorkoutSummaryWidget> {
  int _totalTime = 0;
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();
  var _setsByExercise = Map<String, List<int>>();

  bool _isCurrentWorkout() {
    /// checks if the most recent workout is in the past, or currently taking place
    return !(DateTime.now().difference(_startTime) >= Duration(hours: 2));
  }

  Future<List<int>> _getWorkout() async {
    log("\n[WSWidget] getWorkout... All sets:");
    var sets =
        []; // get recent workout sets; memory intensive when you have enough sets, pull as stream?
    log(sets.toString());
    if (sets.isNotEmpty) {
      var lastSetTime = sets.first.timestamp;
      var workout = getSetsForWorkout(sets, lastSetTime);
      log(workout.toString());
      _startTime = workout.first.timestamp.value; // ts for first set in workout
      _endTime = workout.last.timestamp.value; // ts for last set in workout
      _totalTime = _isCurrentWorkout()
          ? DateTime.now().difference(_startTime).inMinutes
          : _endTime
              .difference(_startTime)
              .inMinutes; // total workout time depends on whether it is a current or old workout
      _setsByExercise = _sortWorkoutByExercise(workout);
      return [];
    }
    return [];
  }

  List<ExerciseSetCompanion> getSetsForWorkout(List allSets, DateTime lastSet) {
    /// filters the sets to find just those for a given workout

    return [];
  }

  Map<String, List<int>> _sortWorkoutByExercise(List workout) {
    /// sorts the sets in order for the workout

    var _sets = Map<String, List<int>>();
    // workout.forEach((int set) async {
    //   // var exercise = await widget._database.getExerciseById(set.exercise);
    //   _setsByExercise.update("test", (value) {
    //     value.add(set);
    //     return value;
    //   }, ifAbsent: () => [set]);
    // });
    return _sets;
  }

  List<ListTile> _getTileForExercise() {
    log("[WorkoutSummaryWidget] getting tile for exercise...");
    List<ListTile> tiles = <ListTile>[];
    _setsByExercise.forEach((exercise, sets) {
      double _totalWeight = 0;
      String postfix = (sets.length > 1) ? "sets" : "set";
      log("\n$exercise");
      sets.forEach((set) {
        // aggregate total weight lifted by exercise
        // log(set.toJsonString());
        // _totalWeight += set.weight * set.repetitions;
      });
      tiles.add(ListTile(
        title: Text(
          exercise.capitalize(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle:
            Text("Total Weight: $_totalWeight lbs. in ${sets.length} $postfix"),
      ));
    });
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
        future: _getWorkout(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _isCurrentWorkout()
                                ? "Current Workout"
                                : "Last Workout",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                              "Start Time: ${_startTime.hour}:${_startTime.minute} on ${_startTime.month}/${_startTime.day}/${_startTime.year}"),
                          Text("Total Time: $_totalTime minutes"),
                          ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: _getTileForExercise(),
                          ),
                        ])));
          }
        });
  }
}
