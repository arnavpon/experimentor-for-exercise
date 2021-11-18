import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:experimentor_for_exercise/models/database.dart';
import 'package:experimentor_for_exercise/views/widgets/workout_summary.dart';
import 'package:experimentor_for_exercise/views/widgets/exercise_autocompleter.dart';
import 'package:experimentor_for_exercise/shared/form_input_validator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _exercise = ""; // name of current exercise
  int _repCount = 0;
  double _weight = 0;

  final _database = MyDatabase(); // single DB connection - provider?
  final _weightFieldController = TextEditingController();

  void _updateExercise(String value) {
    // update function passed to child widget
    this._exercise = value.toLowerCase();
  }

  Future _reportCompletedSet() async {
    if (_formKey.currentState!.validate()) {
      // validate form
      _formKey.currentState!.save(); // save entries
      log("Exercise: $_exercise | Weight: $_weight | Reps; $_repCount");

      // write to db & udate UI
      var matches = await _database.getExercisesForName(_exercise);
      var _exerciseId;
      if (matches.length == 0) {
        // only add exercise -> db if it doesn't already exist
        _exerciseId = await _database.addExercise(
            WeightliftingExercisesCompanion.insert(name: _exercise));
      } else if (matches.length == 1) {
        _exerciseId = matches.first.id;
      } else {
        throw ("Error: more than 1 exercise found with that name!");
      }

      await _database.addSet(WeightliftingSetsCompanion.insert(
          repetitions: _repCount,
          weight: _weight,
          timestamp: DateTime.now(),
          exercise: _exerciseId)); // add set -> db
      var sets = await _database.allSetsSorted; // ***
      log(sets.toString()); // ***

      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values.
        // logic inside here is called BEFORE rebuilding widget
        _formKey.currentState!.reset(); // reset UI
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    this._weightFieldController.text = this._exercise.isEmpty
        ? ""
        : "$_weight"; // reset value of "weight" field w/ last entered weight
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Workout"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: <Widget>[
                    ExerciseAutocompleter(
                      _database,
                      _updateExercise,
                      defaultText: _exercise,
                    ),
                    TextFormField(
                      controller: _weightFieldController,
                      decoration:
                          const InputDecoration(hintText: "weight (lbs.)"),
                      validator: NumericalFormInputValidator().validateInput,
                      onSaved: (String? value) {
                        _weight = double.parse(value!);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "# of reps"),
                      validator: IntegerFormInputValidator().validateInput,
                      onSaved: (String? value) {
                        _repCount = int.parse(value!);
                      },
                    ),
                  ],
                ),
              )),
          WorkoutSummaryWidget(_database),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reportCompletedSet,
        tooltip: 'Enter Set',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
