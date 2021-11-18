import 'package:drift/native.dart';
import 'package:test/test.dart';
import 'package:drift/native.dart';
import 'package:experimentor_for_exercise/models/database.dart';

void main() {
  MyDatabase database;

  setUp(() {
    // set up mock database for testing
    database = MyDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    // destroy mock database after tests run
    await database.close();
  });

  group("Database", () {
    test("***firstTest", () {});
  });
}
