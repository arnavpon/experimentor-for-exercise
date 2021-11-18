import 'dart:developer';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io' as io;

part 'database.g.dart'; // for code generation

/// High Level DB structure
/// Workout > Exercise > Set > Repetition
/// WORKOUT: collection of SETS done all together (within a specified timeframe)
/// - no distinct table needed b/c workout is inferred from sets
/// SET: a NUMBER of times that a specific WEIGHT is lifted (e.g. 100x3) in a specific way (the EXERCISE type)
/// - the set is timestamped b/c it is the basic unit of reporting to the system
/// - we aren't using "REPS" as a distinct table b/c a rep is just a number

class WeightliftingExercises extends Table {
  // Table that lists various types of exercises
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().customConstraint(
      "NOT NULL UNIQUE")(); // name of exercise (should be unique)
  // later on, may decide to add "muscle_groups_impacted" & other columns to run more interesting queries
}

class WeightliftingSets extends Table {
  // Table containing each reported set during a workout
  IntColumn get id => integer().autoIncrement()();
  IntColumn get repetitions => integer()(); // number of reps
  RealColumn get weight => real()(); // amount of weight
  DateTimeColumn get timestamp => dateTime()(); // when value was reported
  IntColumn get exercise => integer().customConstraint(
      "NOT NULL references weightlifting_exercises (id)")(); // references exercise in Exercises table
}

LazyDatabase _openConnection() {
  // asynchronously finds location of db file
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = io.File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [WeightliftingExercises, WeightliftingSets])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(_openConnection()); // tell system in which file to store data
  @override
  int get schemaVersion => 1; // increment when you change table definitions

  // Sets Table

  Future<Iterable<WeightliftingSet>>
      get allSetsSorted => (select(weightliftingSets)
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)
            ]))
          .get();

  Future<int> addSet(WeightliftingSetsCompanion entry) {
    return into(weightliftingSets).insert(entry);
  }

  Future<List<WeightliftingSet>> getSetsForWorkout(DateTime ts) {
    // finds all sets performed within 2 hours of input timestamp
    var lowerBound = ts.subtract(Duration(hours: 2)); // start time
    return (select(weightliftingSets)
          ..where((s) =>
              s.timestamp.isBiggerOrEqualValue(lowerBound) &
              s.timestamp.isSmallerOrEqualValue(ts))
          ..orderBy([(t) => OrderingTerm(expression: t.timestamp)]))
        .get();
  }

  // Exercise Table

  Future<int> addExercise(WeightliftingExercisesCompanion entry) {
    return into(weightliftingExercises).insert(entry);
  }

  Future<List<WeightliftingExercise>> get allExercises =>
      select(weightliftingExercises).get();

  Future<WeightliftingExercise> getExerciseById(int id) {
    return (select(weightliftingExercises)
          ..where((exercise) => exercise.id.equals(id)))
        .getSingle();
  }

  Future<List<WeightliftingExercise>> getExercisesForName(String name) {
    return (select(weightliftingExercises)
          ..where((exercise) => exercise.name.equals(name)))
        .get();
  }

  Stream<List<WeightliftingExercise>> watchExercises() {
    return select(weightliftingExercises)
        .watch(); // stream to keep track if exercise list changes
  }
}
