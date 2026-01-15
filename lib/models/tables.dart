import 'package:drift/drift.dart';

class Movements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class EquipmentTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class ExerciseSet extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get movement => text()();
  TextColumn get equipmentType => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}

class WeightliftingSet extends ExerciseSet {
  IntColumn get nOfReps => integer()();
  RealColumn get weight => real()();
}

class CardioSet extends ExerciseSet {
  RealColumn get distance => real()();
  RealColumn get duration => real()();
  RealColumn get powerOutput => real()();
}
