import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:test/constants.dart';
import 'package:test/models/exercise_set.dart';
import 'views/screens/home_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // open the db and store a reference
  final database = openDatabase(
    join(await getDatabasesPath(), 'emfe_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $TABLE_WEIGHTLIFTINGSETS(id INTEGER PRIMARY KEY AUTO INCREMENT, movement TEXT, equipment_type TEXT, n_reps INTEGER, weight REAL, timestamp INT)');
    },
    version: 1,
  );
  WeightliftingSet.insert(
    database,
    movement: "bench press",
    equipmentType: "dumbbell",
    n_reps: 10,
    weight: 20,
  );
  WeightliftingSet.insert(
    database,
    movement: "deadlift",
    equipmentType: "barbell",
    n_reps: 8,
    weight: 44,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Companion',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeScreen(),
    );
  }
}
