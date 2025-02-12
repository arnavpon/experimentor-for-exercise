import 'package:sqflite/sqflite.dart';
import 'package:test/constants.dart';

class ExerciseSet {
  final String movement; // the movement itself, e.g. "Bench Press"
  final String
      equipmentType; // qualifiers on the movement, e.g. "kettlebell", pull from static class
  final DateTime timestamp; // time at which set was recorded

  ExerciseSet({
    required this.movement,
    required this.equipmentType,
  }) : this.timestamp = DateTime.now();
}

class WeightliftingSet extends ExerciseSet {
  static const tableName = TABLE_WEIGHTLIFTINGSETS;
  final int n_reps;
  final double weight; // how to handle bodyweight exercises?

  WeightliftingSet({
    required String movement,
    required String equipmentType,
    required this.n_reps,
    required this.weight,
  }) : super(movement: movement, equipmentType: equipmentType);

  @override
  String toString() {
    return 'WeightliftingSet{[ts: ${timestamp.toLocal()})] mvmt: $movement, equip: $equipmentType, n_reps: $n_reps, weight: $weight}';
  }

  static Future<void> insert(Future<Database> database,
      {required String movement,
      required equipmentType,
      required n_reps,
      required weight}) async {
    final db = await database;

    var entry = WeightliftingSet(
        movement: movement,
        equipmentType: equipmentType,
        n_reps: n_reps,
        weight: weight);

    // Insert the entry into the table
    await db.insert(
      tableName,
      {
        'movement': entry.movement,
        'equipmentype': entry.equipmentType,
        'n_reps': entry.n_reps,
        'weight': entry.weight,
        'timestamp': entry.timestamp.millisecondsSinceEpoch,
      },
    );
  }

  static Future<void> update(Future<Database> database, int id, String movement,
      String equipmentType, int n_reps, double weight) async {
    final db = await database;

    // Update the columns for the the new data provided
    await db.update(
      tableName,
      {
        'id': id,
        'movement': movement,
        'equipmen_type': equipmentType,
        'n_reps': n_reps,
        'weight': weight,
      },
      // Ensure a matching id.
      where: 'id = ?',
      // Pass the id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<List<ExerciseSet>> getAllSets(Future<Database> database) async {
    /// A method that retrieves all the entries from the table
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the entries
    final List<Map<String, Object?>> allEntries = await db.query(tableName);

    // Convert the list of each entry's fields into a list of objects
    return [
      for (final {
            'movement': movement as String,
            'equipment_type': equipmentType as String,
            'n_reps': n_reps as int,
            'weight': weight as double,
            'timestamp': timestamp as int,
          } in allEntries)
        WeightliftingSet(
            movement: movement,
            equipmentType: equipmentType,
            n_reps: n_reps,
            weight: weight),
    ];
  }

  static Future<void> delete(Future<Database> database, int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the item from the database.
    await db.delete(
      tableName,
      // Use a `where` clause to delete a specific entry.
      where: 'id = ?',
      // Pass the id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
