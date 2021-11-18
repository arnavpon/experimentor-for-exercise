// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class WeightliftingExercise extends DataClass
    implements Insertable<WeightliftingExercise> {
  final int id;
  final String name;
  WeightliftingExercise({required this.id, required this.name});
  factory WeightliftingExercise.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return WeightliftingExercise(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  WeightliftingExercisesCompanion toCompanion(bool nullToAbsent) {
    return WeightliftingExercisesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory WeightliftingExercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightliftingExercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  WeightliftingExercise copyWith({int? id, String? name}) =>
      WeightliftingExercise(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('WeightliftingExercise(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightliftingExercise &&
          other.id == this.id &&
          other.name == this.name);
}

class WeightliftingExercisesCompanion
    extends UpdateCompanion<WeightliftingExercise> {
  final Value<int> id;
  final Value<String> name;
  const WeightliftingExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  WeightliftingExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<WeightliftingExercise> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  WeightliftingExercisesCompanion copyWith(
      {Value<int>? id, Value<String>? name}) {
    return WeightliftingExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightliftingExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $WeightliftingExercisesTable extends WeightliftingExercises
    with TableInfo<$WeightliftingExercisesTable, WeightliftingExercise> {
  final GeneratedDatabase _db;
  final String? _alias;
  $WeightliftingExercisesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'weightlifting_exercises';
  @override
  String get actualTableName => 'weightlifting_exercises';
  @override
  VerificationContext validateIntegrity(
      Insertable<WeightliftingExercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightliftingExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    return WeightliftingExercise.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WeightliftingExercisesTable createAlias(String alias) {
    return $WeightliftingExercisesTable(_db, alias);
  }
}

class WeightliftingSet extends DataClass
    implements Insertable<WeightliftingSet> {
  final int id;
  final int repetitions;
  final double weight;
  final DateTime timestamp;
  final int exercise;
  WeightliftingSet(
      {required this.id,
      required this.repetitions,
      required this.weight,
      required this.timestamp,
      required this.exercise});
  factory WeightliftingSet.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return WeightliftingSet(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      repetitions: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}repetitions'])!,
      weight: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}weight'])!,
      timestamp: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp'])!,
      exercise: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exercise'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['repetitions'] = Variable<int>(repetitions);
    map['weight'] = Variable<double>(weight);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['exercise'] = Variable<int>(exercise);
    return map;
  }

  WeightliftingSetsCompanion toCompanion(bool nullToAbsent) {
    return WeightliftingSetsCompanion(
      id: Value(id),
      repetitions: Value(repetitions),
      weight: Value(weight),
      timestamp: Value(timestamp),
      exercise: Value(exercise),
    );
  }

  factory WeightliftingSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightliftingSet(
      id: serializer.fromJson<int>(json['id']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      weight: serializer.fromJson<double>(json['weight']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      exercise: serializer.fromJson<int>(json['exercise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'repetitions': serializer.toJson<int>(repetitions),
      'weight': serializer.toJson<double>(weight),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'exercise': serializer.toJson<int>(exercise),
    };
  }

  WeightliftingSet copyWith(
          {int? id,
          int? repetitions,
          double? weight,
          DateTime? timestamp,
          int? exercise}) =>
      WeightliftingSet(
        id: id ?? this.id,
        repetitions: repetitions ?? this.repetitions,
        weight: weight ?? this.weight,
        timestamp: timestamp ?? this.timestamp,
        exercise: exercise ?? this.exercise,
      );
  @override
  String toString() {
    return (StringBuffer('WeightliftingSet(')
          ..write('id: $id, ')
          ..write('repetitions: $repetitions, ')
          ..write('weight: $weight, ')
          ..write('timestamp: $timestamp, ')
          ..write('exercise: $exercise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, repetitions, weight, timestamp, exercise);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightliftingSet &&
          other.id == this.id &&
          other.repetitions == this.repetitions &&
          other.weight == this.weight &&
          other.timestamp == this.timestamp &&
          other.exercise == this.exercise);
}

class WeightliftingSetsCompanion extends UpdateCompanion<WeightliftingSet> {
  final Value<int> id;
  final Value<int> repetitions;
  final Value<double> weight;
  final Value<DateTime> timestamp;
  final Value<int> exercise;
  const WeightliftingSetsCompanion({
    this.id = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.weight = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.exercise = const Value.absent(),
  });
  WeightliftingSetsCompanion.insert({
    this.id = const Value.absent(),
    required int repetitions,
    required double weight,
    required DateTime timestamp,
    required int exercise,
  })  : repetitions = Value(repetitions),
        weight = Value(weight),
        timestamp = Value(timestamp),
        exercise = Value(exercise);
  static Insertable<WeightliftingSet> custom({
    Expression<int>? id,
    Expression<int>? repetitions,
    Expression<double>? weight,
    Expression<DateTime>? timestamp,
    Expression<int>? exercise,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repetitions != null) 'repetitions': repetitions,
      if (weight != null) 'weight': weight,
      if (timestamp != null) 'timestamp': timestamp,
      if (exercise != null) 'exercise': exercise,
    });
  }

  WeightliftingSetsCompanion copyWith(
      {Value<int>? id,
      Value<int>? repetitions,
      Value<double>? weight,
      Value<DateTime>? timestamp,
      Value<int>? exercise}) {
    return WeightliftingSetsCompanion(
      id: id ?? this.id,
      repetitions: repetitions ?? this.repetitions,
      weight: weight ?? this.weight,
      timestamp: timestamp ?? this.timestamp,
      exercise: exercise ?? this.exercise,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (exercise.present) {
      map['exercise'] = Variable<int>(exercise.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightliftingSetsCompanion(')
          ..write('id: $id, ')
          ..write('repetitions: $repetitions, ')
          ..write('weight: $weight, ')
          ..write('timestamp: $timestamp, ')
          ..write('exercise: $exercise')
          ..write(')'))
        .toString();
  }
}

class $WeightliftingSetsTable extends WeightliftingSets
    with TableInfo<$WeightliftingSetsTable, WeightliftingSet> {
  final GeneratedDatabase _db;
  final String? _alias;
  $WeightliftingSetsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _repetitionsMeta =
      const VerificationMeta('repetitions');
  late final GeneratedColumn<int?> repetitions = GeneratedColumn<int?>(
      'repetitions', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  late final GeneratedColumn<double?> weight = GeneratedColumn<double?>(
      'weight', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  late final GeneratedColumn<DateTime?> timestamp = GeneratedColumn<DateTime?>(
      'timestamp', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _exerciseMeta = const VerificationMeta('exercise');
  late final GeneratedColumn<int?> exercise = GeneratedColumn<int?>(
      'exercise', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL references weightlifting_exercises (id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, repetitions, weight, timestamp, exercise];
  @override
  String get aliasedName => _alias ?? 'weightlifting_sets';
  @override
  String get actualTableName => 'weightlifting_sets';
  @override
  VerificationContext validateIntegrity(Insertable<WeightliftingSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('repetitions')) {
      context.handle(
          _repetitionsMeta,
          repetitions.isAcceptableOrUnknown(
              data['repetitions']!, _repetitionsMeta));
    } else if (isInserting) {
      context.missing(_repetitionsMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('exercise')) {
      context.handle(_exerciseMeta,
          exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta));
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightliftingSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    return WeightliftingSet.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WeightliftingSetsTable createAlias(String alias) {
    return $WeightliftingSetsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $WeightliftingExercisesTable weightliftingExercises =
      $WeightliftingExercisesTable(this);
  late final $WeightliftingSetsTable weightliftingSets =
      $WeightliftingSetsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [weightliftingExercises, weightliftingSets];
}
