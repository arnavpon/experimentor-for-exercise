import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Movements,
  EquipmentTypes,
  ExerciseSet,
  WeightliftingSet,
  CardioSet
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'experimentor-for-exercise-app',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'Using ${result.chosenImplementation} due to unsupported '
              'browser features: ${result.missingFeatures}',
            );
          }
        },
      ),
    );
  }

  static Future<void> updateEntry(AppDatabase db, int id, String movement,
      int nOfReps, double weight, String equipmentType) async {
    // First, get the original record to preserve its timestamp
    final originalRecord = await (db.select(db.weightliftingSet)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    // Update the record with the new values but keep the original timestamp
    await db.update(db.weightliftingSet).replace(
          WeightliftingSetData(
            id: id,
            movement: movement,
            equipmentType: equipmentType,
            nOfReps: nOfReps,
            weight: weight,
            timestamp:
                originalRecord.timestamp, // Preserve the original timestamp
          ),
        );
  }
}
