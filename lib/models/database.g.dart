// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MovementsTable extends Movements
    with TableInfo<$MovementsTable, Movement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movements';
  @override
  VerificationContext validateIntegrity(Insertable<Movement> instance,
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
  Movement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Movement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $MovementsTable createAlias(String alias) {
    return $MovementsTable(attachedDatabase, alias);
  }
}

class Movement extends DataClass implements Insertable<Movement> {
  final int id;
  final String name;
  const Movement({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  MovementsCompanion toCompanion(bool nullToAbsent) {
    return MovementsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Movement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Movement(
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

  Movement copyWith({int? id, String? name}) => Movement(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Movement copyWithCompanion(MovementsCompanion data) {
    return Movement(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Movement(')
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
      (other is Movement && other.id == this.id && other.name == this.name);
}

class MovementsCompanion extends UpdateCompanion<Movement> {
  final Value<int> id;
  final Value<String> name;
  const MovementsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  MovementsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Movement> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  MovementsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return MovementsCompanion(
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
    return (StringBuffer('MovementsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $EquipmentTypesTable extends EquipmentTypes
    with TableInfo<$EquipmentTypesTable, EquipmentType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment_types';
  @override
  VerificationContext validateIntegrity(Insertable<EquipmentType> instance,
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
  EquipmentType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $EquipmentTypesTable createAlias(String alias) {
    return $EquipmentTypesTable(attachedDatabase, alias);
  }
}

class EquipmentType extends DataClass implements Insertable<EquipmentType> {
  final int id;
  final String name;
  const EquipmentType({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  EquipmentTypesCompanion toCompanion(bool nullToAbsent) {
    return EquipmentTypesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory EquipmentType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentType(
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

  EquipmentType copyWith({int? id, String? name}) => EquipmentType(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  EquipmentType copyWithCompanion(EquipmentTypesCompanion data) {
    return EquipmentType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentType(')
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
      (other is EquipmentType &&
          other.id == this.id &&
          other.name == this.name);
}

class EquipmentTypesCompanion extends UpdateCompanion<EquipmentType> {
  final Value<int> id;
  final Value<String> name;
  const EquipmentTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  EquipmentTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<EquipmentType> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  EquipmentTypesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return EquipmentTypesCompanion(
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
    return (StringBuffer('EquipmentTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetTable extends ExerciseSet
    with TableInfo<$ExerciseSetTable, ExerciseSetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _movementMeta =
      const VerificationMeta('movement');
  @override
  late final GeneratedColumn<String> movement = GeneratedColumn<String>(
      'movement', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _equipmentTypeMeta =
      const VerificationMeta('equipmentType');
  @override
  late final GeneratedColumn<String> equipmentType = GeneratedColumn<String>(
      'equipment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, movement, equipmentType, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_set';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseSetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('movement')) {
      context.handle(_movementMeta,
          movement.isAcceptableOrUnknown(data['movement']!, _movementMeta));
    } else if (isInserting) {
      context.missing(_movementMeta);
    }
    if (data.containsKey('equipment_type')) {
      context.handle(
          _equipmentTypeMeta,
          equipmentType.isAcceptableOrUnknown(
              data['equipment_type']!, _equipmentTypeMeta));
    } else if (isInserting) {
      context.missing(_equipmentTypeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseSetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      movement: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}movement'])!,
      equipmentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipment_type'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ExerciseSetTable createAlias(String alias) {
    return $ExerciseSetTable(attachedDatabase, alias);
  }
}

class ExerciseSetData extends DataClass implements Insertable<ExerciseSetData> {
  final int id;
  final String movement;
  final String equipmentType;
  final DateTime timestamp;
  const ExerciseSetData(
      {required this.id,
      required this.movement,
      required this.equipmentType,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['movement'] = Variable<String>(movement);
    map['equipment_type'] = Variable<String>(equipmentType);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  ExerciseSetCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetCompanion(
      id: Value(id),
      movement: Value(movement),
      equipmentType: Value(equipmentType),
      timestamp: Value(timestamp),
    );
  }

  factory ExerciseSetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSetData(
      id: serializer.fromJson<int>(json['id']),
      movement: serializer.fromJson<String>(json['movement']),
      equipmentType: serializer.fromJson<String>(json['equipmentType']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'movement': serializer.toJson<String>(movement),
      'equipmentType': serializer.toJson<String>(equipmentType),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  ExerciseSetData copyWith(
          {int? id,
          String? movement,
          String? equipmentType,
          DateTime? timestamp}) =>
      ExerciseSetData(
        id: id ?? this.id,
        movement: movement ?? this.movement,
        equipmentType: equipmentType ?? this.equipmentType,
        timestamp: timestamp ?? this.timestamp,
      );
  ExerciseSetData copyWithCompanion(ExerciseSetCompanion data) {
    return ExerciseSetData(
      id: data.id.present ? data.id.value : this.id,
      movement: data.movement.present ? data.movement.value : this.movement,
      equipmentType: data.equipmentType.present
          ? data.equipmentType.value
          : this.equipmentType,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetData(')
          ..write('id: $id, ')
          ..write('movement: $movement, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, movement, equipmentType, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSetData &&
          other.id == this.id &&
          other.movement == this.movement &&
          other.equipmentType == this.equipmentType &&
          other.timestamp == this.timestamp);
}

class ExerciseSetCompanion extends UpdateCompanion<ExerciseSetData> {
  final Value<int> id;
  final Value<String> movement;
  final Value<String> equipmentType;
  final Value<DateTime> timestamp;
  const ExerciseSetCompanion({
    this.id = const Value.absent(),
    this.movement = const Value.absent(),
    this.equipmentType = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  ExerciseSetCompanion.insert({
    this.id = const Value.absent(),
    required String movement,
    required String equipmentType,
    this.timestamp = const Value.absent(),
  })  : movement = Value(movement),
        equipmentType = Value(equipmentType);
  static Insertable<ExerciseSetData> custom({
    Expression<int>? id,
    Expression<String>? movement,
    Expression<String>? equipmentType,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (movement != null) 'movement': movement,
      if (equipmentType != null) 'equipment_type': equipmentType,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  ExerciseSetCompanion copyWith(
      {Value<int>? id,
      Value<String>? movement,
      Value<String>? equipmentType,
      Value<DateTime>? timestamp}) {
    return ExerciseSetCompanion(
      id: id ?? this.id,
      movement: movement ?? this.movement,
      equipmentType: equipmentType ?? this.equipmentType,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (movement.present) {
      map['movement'] = Variable<String>(movement.value);
    }
    if (equipmentType.present) {
      map['equipment_type'] = Variable<String>(equipmentType.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetCompanion(')
          ..write('id: $id, ')
          ..write('movement: $movement, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $WeightliftingSetTable extends WeightliftingSet
    with TableInfo<$WeightliftingSetTable, WeightliftingSetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightliftingSetTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _movementMeta =
      const VerificationMeta('movement');
  @override
  late final GeneratedColumn<String> movement = GeneratedColumn<String>(
      'movement', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _equipmentTypeMeta =
      const VerificationMeta('equipmentType');
  @override
  late final GeneratedColumn<String> equipmentType = GeneratedColumn<String>(
      'equipment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _nOfRepsMeta =
      const VerificationMeta('nOfReps');
  @override
  late final GeneratedColumn<int> nOfReps = GeneratedColumn<int>(
      'n_of_reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, movement, equipmentType, timestamp, nOfReps, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weightlifting_set';
  @override
  VerificationContext validateIntegrity(
      Insertable<WeightliftingSetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('movement')) {
      context.handle(_movementMeta,
          movement.isAcceptableOrUnknown(data['movement']!, _movementMeta));
    } else if (isInserting) {
      context.missing(_movementMeta);
    }
    if (data.containsKey('equipment_type')) {
      context.handle(
          _equipmentTypeMeta,
          equipmentType.isAcceptableOrUnknown(
              data['equipment_type']!, _equipmentTypeMeta));
    } else if (isInserting) {
      context.missing(_equipmentTypeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('n_of_reps')) {
      context.handle(_nOfRepsMeta,
          nOfReps.isAcceptableOrUnknown(data['n_of_reps']!, _nOfRepsMeta));
    } else if (isInserting) {
      context.missing(_nOfRepsMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightliftingSetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightliftingSetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      movement: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}movement'])!,
      equipmentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipment_type'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      nOfReps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}n_of_reps'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
    );
  }

  @override
  $WeightliftingSetTable createAlias(String alias) {
    return $WeightliftingSetTable(attachedDatabase, alias);
  }
}

class WeightliftingSetData extends DataClass
    implements Insertable<WeightliftingSetData> {
  final int id;
  final String movement;
  final String equipmentType;
  final DateTime timestamp;
  final int nOfReps;
  final double weight;
  const WeightliftingSetData(
      {required this.id,
      required this.movement,
      required this.equipmentType,
      required this.timestamp,
      required this.nOfReps,
      required this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['movement'] = Variable<String>(movement);
    map['equipment_type'] = Variable<String>(equipmentType);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['n_of_reps'] = Variable<int>(nOfReps);
    map['weight'] = Variable<double>(weight);
    return map;
  }

  WeightliftingSetCompanion toCompanion(bool nullToAbsent) {
    return WeightliftingSetCompanion(
      id: Value(id),
      movement: Value(movement),
      equipmentType: Value(equipmentType),
      timestamp: Value(timestamp),
      nOfReps: Value(nOfReps),
      weight: Value(weight),
    );
  }

  factory WeightliftingSetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightliftingSetData(
      id: serializer.fromJson<int>(json['id']),
      movement: serializer.fromJson<String>(json['movement']),
      equipmentType: serializer.fromJson<String>(json['equipmentType']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      nOfReps: serializer.fromJson<int>(json['nOfReps']),
      weight: serializer.fromJson<double>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'movement': serializer.toJson<String>(movement),
      'equipmentType': serializer.toJson<String>(equipmentType),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'nOfReps': serializer.toJson<int>(nOfReps),
      'weight': serializer.toJson<double>(weight),
    };
  }

  WeightliftingSetData copyWith(
          {int? id,
          String? movement,
          String? equipmentType,
          DateTime? timestamp,
          int? nOfReps,
          double? weight}) =>
      WeightliftingSetData(
        id: id ?? this.id,
        movement: movement ?? this.movement,
        equipmentType: equipmentType ?? this.equipmentType,
        timestamp: timestamp ?? this.timestamp,
        nOfReps: nOfReps ?? this.nOfReps,
        weight: weight ?? this.weight,
      );
  WeightliftingSetData copyWithCompanion(WeightliftingSetCompanion data) {
    return WeightliftingSetData(
      id: data.id.present ? data.id.value : this.id,
      movement: data.movement.present ? data.movement.value : this.movement,
      equipmentType: data.equipmentType.present
          ? data.equipmentType.value
          : this.equipmentType,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      nOfReps: data.nOfReps.present ? data.nOfReps.value : this.nOfReps,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightliftingSetData(')
          ..write('id: $id, ')
          ..write('movement: $movement, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('timestamp: $timestamp, ')
          ..write('nOfReps: $nOfReps, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, movement, equipmentType, timestamp, nOfReps, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightliftingSetData &&
          other.id == this.id &&
          other.movement == this.movement &&
          other.equipmentType == this.equipmentType &&
          other.timestamp == this.timestamp &&
          other.nOfReps == this.nOfReps &&
          other.weight == this.weight);
}

class WeightliftingSetCompanion extends UpdateCompanion<WeightliftingSetData> {
  final Value<int> id;
  final Value<String> movement;
  final Value<String> equipmentType;
  final Value<DateTime> timestamp;
  final Value<int> nOfReps;
  final Value<double> weight;
  const WeightliftingSetCompanion({
    this.id = const Value.absent(),
    this.movement = const Value.absent(),
    this.equipmentType = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.nOfReps = const Value.absent(),
    this.weight = const Value.absent(),
  });
  WeightliftingSetCompanion.insert({
    this.id = const Value.absent(),
    required String movement,
    required String equipmentType,
    this.timestamp = const Value.absent(),
    required int nOfReps,
    required double weight,
  })  : movement = Value(movement),
        equipmentType = Value(equipmentType),
        nOfReps = Value(nOfReps),
        weight = Value(weight);
  static Insertable<WeightliftingSetData> custom({
    Expression<int>? id,
    Expression<String>? movement,
    Expression<String>? equipmentType,
    Expression<DateTime>? timestamp,
    Expression<int>? nOfReps,
    Expression<double>? weight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (movement != null) 'movement': movement,
      if (equipmentType != null) 'equipment_type': equipmentType,
      if (timestamp != null) 'timestamp': timestamp,
      if (nOfReps != null) 'n_of_reps': nOfReps,
      if (weight != null) 'weight': weight,
    });
  }

  WeightliftingSetCompanion copyWith(
      {Value<int>? id,
      Value<String>? movement,
      Value<String>? equipmentType,
      Value<DateTime>? timestamp,
      Value<int>? nOfReps,
      Value<double>? weight}) {
    return WeightliftingSetCompanion(
      id: id ?? this.id,
      movement: movement ?? this.movement,
      equipmentType: equipmentType ?? this.equipmentType,
      timestamp: timestamp ?? this.timestamp,
      nOfReps: nOfReps ?? this.nOfReps,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (movement.present) {
      map['movement'] = Variable<String>(movement.value);
    }
    if (equipmentType.present) {
      map['equipment_type'] = Variable<String>(equipmentType.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (nOfReps.present) {
      map['n_of_reps'] = Variable<int>(nOfReps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightliftingSetCompanion(')
          ..write('id: $id, ')
          ..write('movement: $movement, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('timestamp: $timestamp, ')
          ..write('nOfReps: $nOfReps, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

class $CardioSetTable extends CardioSet
    with TableInfo<$CardioSetTable, CardioSetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardioSetTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _movementMeta =
      const VerificationMeta('movement');
  @override
  late final GeneratedColumn<String> movement = GeneratedColumn<String>(
      'movement', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _equipmentTypeMeta =
      const VerificationMeta('equipmentType');
  @override
  late final GeneratedColumn<String> equipmentType = GeneratedColumn<String>(
      'equipment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _distanceMeta =
      const VerificationMeta('distance');
  @override
  late final GeneratedColumn<double> distance = GeneratedColumn<double>(
      'distance', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<double> duration = GeneratedColumn<double>(
      'duration', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, movement, equipmentType, timestamp, distance, duration];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cardio_set';
  @override
  VerificationContext validateIntegrity(Insertable<CardioSetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('movement')) {
      context.handle(_movementMeta,
          movement.isAcceptableOrUnknown(data['movement']!, _movementMeta));
    } else if (isInserting) {
      context.missing(_movementMeta);
    }
    if (data.containsKey('equipment_type')) {
      context.handle(
          _equipmentTypeMeta,
          equipmentType.isAcceptableOrUnknown(
              data['equipment_type']!, _equipmentTypeMeta));
    } else if (isInserting) {
      context.missing(_equipmentTypeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta));
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardioSetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardioSetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      movement: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}movement'])!,
      equipmentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipment_type'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      distance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}duration'])!,
    );
  }

  @override
  $CardioSetTable createAlias(String alias) {
    return $CardioSetTable(attachedDatabase, alias);
  }
}

class CardioSetData extends DataClass implements Insertable<CardioSetData> {
  final int id;
  final String movement;
  final String equipmentType;
  final DateTime timestamp;
  final double distance;
  final double duration;
  const CardioSetData(
      {required this.id,
      required this.movement,
      required this.equipmentType,
      required this.timestamp,
      required this.distance,
      required this.duration});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['movement'] = Variable<String>(movement);
    map['equipment_type'] = Variable<String>(equipmentType);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['distance'] = Variable<double>(distance);
    map['duration'] = Variable<double>(duration);
    return map;
  }

  CardioSetCompanion toCompanion(bool nullToAbsent) {
    return CardioSetCompanion(
      id: Value(id),
      movement: Value(movement),
      equipmentType: Value(equipmentType),
      timestamp: Value(timestamp),
      distance: Value(distance),
      duration: Value(duration),
    );
  }

  factory CardioSetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardioSetData(
      id: serializer.fromJson<int>(json['id']),
      movement: serializer.fromJson<String>(json['movement']),
      equipmentType: serializer.fromJson<String>(json['equipmentType']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      distance: serializer.fromJson<double>(json['distance']),
      duration: serializer.fromJson<double>(json['duration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'movement': serializer.toJson<String>(movement),
      'equipmentType': serializer.toJson<String>(equipmentType),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'distance': serializer.toJson<double>(distance),
      'duration': serializer.toJson<double>(duration),
    };
  }

  CardioSetData copyWith(
          {int? id,
          String? movement,
          String? equipmentType,
          DateTime? timestamp,
          double? distance,
          double? duration}) =>
      CardioSetData(
        id: id ?? this.id,
        movement: movement ?? this.movement,
        equipmentType: equipmentType ?? this.equipmentType,
        timestamp: timestamp ?? this.timestamp,
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
      );
  CardioSetData copyWithCompanion(CardioSetCompanion data) {
    return CardioSetData(
      id: data.id.present ? data.id.value : this.id,
      movement: data.movement.present ? data.movement.value : this.movement,
      equipmentType: data.equipmentType.present
          ? data.equipmentType.value
          : this.equipmentType,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      distance: data.distance.present ? data.distance.value : this.distance,
      duration: data.duration.present ? data.duration.value : this.duration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardioSetData(')
          ..write('id: $id, ')
          ..write('movement: $movement, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('timestamp: $timestamp, ')
          ..write('distance: $distance, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, movement, equipmentType, timestamp, distance, duration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardioSetData &&
          other.id == this.id &&
          other.movement == this.movement &&
          other.equipmentType == this.equipmentType &&
          other.timestamp == this.timestamp &&
          other.distance == this.distance &&
          other.duration == this.duration);
}

class CardioSetCompanion extends UpdateCompanion<CardioSetData> {
  final Value<int> id;
  final Value<String> movement;
  final Value<String> equipmentType;
  final Value<DateTime> timestamp;
  final Value<double> distance;
  final Value<double> duration;
  const CardioSetCompanion({
    this.id = const Value.absent(),
    this.movement = const Value.absent(),
    this.equipmentType = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.distance = const Value.absent(),
    this.duration = const Value.absent(),
  });
  CardioSetCompanion.insert({
    this.id = const Value.absent(),
    required String movement,
    required String equipmentType,
    this.timestamp = const Value.absent(),
    required double distance,
    required double duration,
  })  : movement = Value(movement),
        equipmentType = Value(equipmentType),
        distance = Value(distance),
        duration = Value(duration);
  static Insertable<CardioSetData> custom({
    Expression<int>? id,
    Expression<String>? movement,
    Expression<String>? equipmentType,
    Expression<DateTime>? timestamp,
    Expression<double>? distance,
    Expression<double>? duration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (movement != null) 'movement': movement,
      if (equipmentType != null) 'equipment_type': equipmentType,
      if (timestamp != null) 'timestamp': timestamp,
      if (distance != null) 'distance': distance,
      if (duration != null) 'duration': duration,
    });
  }

  CardioSetCompanion copyWith(
      {Value<int>? id,
      Value<String>? movement,
      Value<String>? equipmentType,
      Value<DateTime>? timestamp,
      Value<double>? distance,
      Value<double>? duration}) {
    return CardioSetCompanion(
      id: id ?? this.id,
      movement: movement ?? this.movement,
      equipmentType: equipmentType ?? this.equipmentType,
      timestamp: timestamp ?? this.timestamp,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (movement.present) {
      map['movement'] = Variable<String>(movement.value);
    }
    if (equipmentType.present) {
      map['equipment_type'] = Variable<String>(equipmentType.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    if (duration.present) {
      map['duration'] = Variable<double>(duration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardioSetCompanion(')
          ..write('id: $id, ')
          ..write('movement: $movement, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('timestamp: $timestamp, ')
          ..write('distance: $distance, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MovementsTable movements = $MovementsTable(this);
  late final $EquipmentTypesTable equipmentTypes = $EquipmentTypesTable(this);
  late final $ExerciseSetTable exerciseSet = $ExerciseSetTable(this);
  late final $WeightliftingSetTable weightliftingSet =
      $WeightliftingSetTable(this);
  late final $CardioSetTable cardioSet = $CardioSetTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [movements, equipmentTypes, exerciseSet, weightliftingSet, cardioSet];
}

typedef $$MovementsTableCreateCompanionBuilder = MovementsCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$MovementsTableUpdateCompanionBuilder = MovementsCompanion Function({
  Value<int> id,
  Value<String> name,
});

class $$MovementsTableFilterComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$MovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$MovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$MovementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MovementsTable,
    Movement,
    $$MovementsTableFilterComposer,
    $$MovementsTableOrderingComposer,
    $$MovementsTableAnnotationComposer,
    $$MovementsTableCreateCompanionBuilder,
    $$MovementsTableUpdateCompanionBuilder,
    (Movement, BaseReferences<_$AppDatabase, $MovementsTable, Movement>),
    Movement,
    PrefetchHooks Function()> {
  $$MovementsTableTableManager(_$AppDatabase db, $MovementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              MovementsCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              MovementsCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MovementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MovementsTable,
    Movement,
    $$MovementsTableFilterComposer,
    $$MovementsTableOrderingComposer,
    $$MovementsTableAnnotationComposer,
    $$MovementsTableCreateCompanionBuilder,
    $$MovementsTableUpdateCompanionBuilder,
    (Movement, BaseReferences<_$AppDatabase, $MovementsTable, Movement>),
    Movement,
    PrefetchHooks Function()>;
typedef $$EquipmentTypesTableCreateCompanionBuilder = EquipmentTypesCompanion
    Function({
  Value<int> id,
  required String name,
});
typedef $$EquipmentTypesTableUpdateCompanionBuilder = EquipmentTypesCompanion
    Function({
  Value<int> id,
  Value<String> name,
});

class $$EquipmentTypesTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentTypesTable> {
  $$EquipmentTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$EquipmentTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentTypesTable> {
  $$EquipmentTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$EquipmentTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentTypesTable> {
  $$EquipmentTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$EquipmentTypesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EquipmentTypesTable,
    EquipmentType,
    $$EquipmentTypesTableFilterComposer,
    $$EquipmentTypesTableOrderingComposer,
    $$EquipmentTypesTableAnnotationComposer,
    $$EquipmentTypesTableCreateCompanionBuilder,
    $$EquipmentTypesTableUpdateCompanionBuilder,
    (
      EquipmentType,
      BaseReferences<_$AppDatabase, $EquipmentTypesTable, EquipmentType>
    ),
    EquipmentType,
    PrefetchHooks Function()> {
  $$EquipmentTypesTableTableManager(
      _$AppDatabase db, $EquipmentTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipmentTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              EquipmentTypesCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              EquipmentTypesCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EquipmentTypesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EquipmentTypesTable,
    EquipmentType,
    $$EquipmentTypesTableFilterComposer,
    $$EquipmentTypesTableOrderingComposer,
    $$EquipmentTypesTableAnnotationComposer,
    $$EquipmentTypesTableCreateCompanionBuilder,
    $$EquipmentTypesTableUpdateCompanionBuilder,
    (
      EquipmentType,
      BaseReferences<_$AppDatabase, $EquipmentTypesTable, EquipmentType>
    ),
    EquipmentType,
    PrefetchHooks Function()>;
typedef $$ExerciseSetTableCreateCompanionBuilder = ExerciseSetCompanion
    Function({
  Value<int> id,
  required String movement,
  required String equipmentType,
  Value<DateTime> timestamp,
});
typedef $$ExerciseSetTableUpdateCompanionBuilder = ExerciseSetCompanion
    Function({
  Value<int> id,
  Value<String> movement,
  Value<String> equipmentType,
  Value<DateTime> timestamp,
});

class $$ExerciseSetTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSetTable> {
  $$ExerciseSetTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get movement => $composableBuilder(
      column: $table.movement, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ExerciseSetTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSetTable> {
  $$ExerciseSetTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get movement => $composableBuilder(
      column: $table.movement, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ExerciseSetTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSetTable> {
  $$ExerciseSetTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get movement =>
      $composableBuilder(column: $table.movement, builder: (column) => column);

  GeneratedColumn<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ExerciseSetTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseSetTable,
    ExerciseSetData,
    $$ExerciseSetTableFilterComposer,
    $$ExerciseSetTableOrderingComposer,
    $$ExerciseSetTableAnnotationComposer,
    $$ExerciseSetTableCreateCompanionBuilder,
    $$ExerciseSetTableUpdateCompanionBuilder,
    (
      ExerciseSetData,
      BaseReferences<_$AppDatabase, $ExerciseSetTable, ExerciseSetData>
    ),
    ExerciseSetData,
    PrefetchHooks Function()> {
  $$ExerciseSetTableTableManager(_$AppDatabase db, $ExerciseSetTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSetTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSetTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseSetTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> movement = const Value.absent(),
            Value<String> equipmentType = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              ExerciseSetCompanion(
            id: id,
            movement: movement,
            equipmentType: equipmentType,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String movement,
            required String equipmentType,
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              ExerciseSetCompanion.insert(
            id: id,
            movement: movement,
            equipmentType: equipmentType,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExerciseSetTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseSetTable,
    ExerciseSetData,
    $$ExerciseSetTableFilterComposer,
    $$ExerciseSetTableOrderingComposer,
    $$ExerciseSetTableAnnotationComposer,
    $$ExerciseSetTableCreateCompanionBuilder,
    $$ExerciseSetTableUpdateCompanionBuilder,
    (
      ExerciseSetData,
      BaseReferences<_$AppDatabase, $ExerciseSetTable, ExerciseSetData>
    ),
    ExerciseSetData,
    PrefetchHooks Function()>;
typedef $$WeightliftingSetTableCreateCompanionBuilder
    = WeightliftingSetCompanion Function({
  Value<int> id,
  required String movement,
  required String equipmentType,
  Value<DateTime> timestamp,
  required int nOfReps,
  required double weight,
});
typedef $$WeightliftingSetTableUpdateCompanionBuilder
    = WeightliftingSetCompanion Function({
  Value<int> id,
  Value<String> movement,
  Value<String> equipmentType,
  Value<DateTime> timestamp,
  Value<int> nOfReps,
  Value<double> weight,
});

class $$WeightliftingSetTableFilterComposer
    extends Composer<_$AppDatabase, $WeightliftingSetTable> {
  $$WeightliftingSetTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get movement => $composableBuilder(
      column: $table.movement, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nOfReps => $composableBuilder(
      column: $table.nOfReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));
}

class $$WeightliftingSetTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightliftingSetTable> {
  $$WeightliftingSetTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get movement => $composableBuilder(
      column: $table.movement, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nOfReps => $composableBuilder(
      column: $table.nOfReps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));
}

class $$WeightliftingSetTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightliftingSetTable> {
  $$WeightliftingSetTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get movement =>
      $composableBuilder(column: $table.movement, builder: (column) => column);

  GeneratedColumn<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get nOfReps =>
      $composableBuilder(column: $table.nOfReps, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);
}

class $$WeightliftingSetTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeightliftingSetTable,
    WeightliftingSetData,
    $$WeightliftingSetTableFilterComposer,
    $$WeightliftingSetTableOrderingComposer,
    $$WeightliftingSetTableAnnotationComposer,
    $$WeightliftingSetTableCreateCompanionBuilder,
    $$WeightliftingSetTableUpdateCompanionBuilder,
    (
      WeightliftingSetData,
      BaseReferences<_$AppDatabase, $WeightliftingSetTable,
          WeightliftingSetData>
    ),
    WeightliftingSetData,
    PrefetchHooks Function()> {
  $$WeightliftingSetTableTableManager(
      _$AppDatabase db, $WeightliftingSetTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightliftingSetTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightliftingSetTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightliftingSetTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> movement = const Value.absent(),
            Value<String> equipmentType = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> nOfReps = const Value.absent(),
            Value<double> weight = const Value.absent(),
          }) =>
              WeightliftingSetCompanion(
            id: id,
            movement: movement,
            equipmentType: equipmentType,
            timestamp: timestamp,
            nOfReps: nOfReps,
            weight: weight,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String movement,
            required String equipmentType,
            Value<DateTime> timestamp = const Value.absent(),
            required int nOfReps,
            required double weight,
          }) =>
              WeightliftingSetCompanion.insert(
            id: id,
            movement: movement,
            equipmentType: equipmentType,
            timestamp: timestamp,
            nOfReps: nOfReps,
            weight: weight,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeightliftingSetTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeightliftingSetTable,
    WeightliftingSetData,
    $$WeightliftingSetTableFilterComposer,
    $$WeightliftingSetTableOrderingComposer,
    $$WeightliftingSetTableAnnotationComposer,
    $$WeightliftingSetTableCreateCompanionBuilder,
    $$WeightliftingSetTableUpdateCompanionBuilder,
    (
      WeightliftingSetData,
      BaseReferences<_$AppDatabase, $WeightliftingSetTable,
          WeightliftingSetData>
    ),
    WeightliftingSetData,
    PrefetchHooks Function()>;
typedef $$CardioSetTableCreateCompanionBuilder = CardioSetCompanion Function({
  Value<int> id,
  required String movement,
  required String equipmentType,
  Value<DateTime> timestamp,
  required double distance,
  required double duration,
});
typedef $$CardioSetTableUpdateCompanionBuilder = CardioSetCompanion Function({
  Value<int> id,
  Value<String> movement,
  Value<String> equipmentType,
  Value<DateTime> timestamp,
  Value<double> distance,
  Value<double> duration,
});

class $$CardioSetTableFilterComposer
    extends Composer<_$AppDatabase, $CardioSetTable> {
  $$CardioSetTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get movement => $composableBuilder(
      column: $table.movement, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get distance => $composableBuilder(
      column: $table.distance, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));
}

class $$CardioSetTableOrderingComposer
    extends Composer<_$AppDatabase, $CardioSetTable> {
  $$CardioSetTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get movement => $composableBuilder(
      column: $table.movement, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get distance => $composableBuilder(
      column: $table.distance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));
}

class $$CardioSetTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardioSetTable> {
  $$CardioSetTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get movement =>
      $composableBuilder(column: $table.movement, builder: (column) => column);

  GeneratedColumn<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get distance =>
      $composableBuilder(column: $table.distance, builder: (column) => column);

  GeneratedColumn<double> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);
}

class $$CardioSetTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardioSetTable,
    CardioSetData,
    $$CardioSetTableFilterComposer,
    $$CardioSetTableOrderingComposer,
    $$CardioSetTableAnnotationComposer,
    $$CardioSetTableCreateCompanionBuilder,
    $$CardioSetTableUpdateCompanionBuilder,
    (
      CardioSetData,
      BaseReferences<_$AppDatabase, $CardioSetTable, CardioSetData>
    ),
    CardioSetData,
    PrefetchHooks Function()> {
  $$CardioSetTableTableManager(_$AppDatabase db, $CardioSetTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardioSetTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardioSetTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardioSetTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> movement = const Value.absent(),
            Value<String> equipmentType = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<double> distance = const Value.absent(),
            Value<double> duration = const Value.absent(),
          }) =>
              CardioSetCompanion(
            id: id,
            movement: movement,
            equipmentType: equipmentType,
            timestamp: timestamp,
            distance: distance,
            duration: duration,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String movement,
            required String equipmentType,
            Value<DateTime> timestamp = const Value.absent(),
            required double distance,
            required double duration,
          }) =>
              CardioSetCompanion.insert(
            id: id,
            movement: movement,
            equipmentType: equipmentType,
            timestamp: timestamp,
            distance: distance,
            duration: duration,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CardioSetTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardioSetTable,
    CardioSetData,
    $$CardioSetTableFilterComposer,
    $$CardioSetTableOrderingComposer,
    $$CardioSetTableAnnotationComposer,
    $$CardioSetTableCreateCompanionBuilder,
    $$CardioSetTableUpdateCompanionBuilder,
    (
      CardioSetData,
      BaseReferences<_$AppDatabase, $CardioSetTable, CardioSetData>
    ),
    CardioSetData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db, _db.movements);
  $$EquipmentTypesTableTableManager get equipmentTypes =>
      $$EquipmentTypesTableTableManager(_db, _db.equipmentTypes);
  $$ExerciseSetTableTableManager get exerciseSet =>
      $$ExerciseSetTableTableManager(_db, _db.exerciseSet);
  $$WeightliftingSetTableTableManager get weightliftingSet =>
      $$WeightliftingSetTableTableManager(_db, _db.weightliftingSet);
  $$CardioSetTableTableManager get cardioSet =>
      $$CardioSetTableTableManager(_db, _db.cardioSet);
}
