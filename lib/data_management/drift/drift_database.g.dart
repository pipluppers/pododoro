// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $TimerTableTable extends TimerTable
    with TableInfo<$TimerTableTable, TimerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimerTableTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _totalWorkMinutesMeta =
      const VerificationMeta('totalWorkMinutes');
  @override
  late final GeneratedColumn<int> totalWorkMinutes = GeneratedColumn<int>(
      'total_work_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (total_work_minutes >= 0 AND total_work_minutes < 60)');
  static const VerificationMeta _totalWorkSecondsMeta =
      const VerificationMeta('totalWorkSeconds');
  @override
  late final GeneratedColumn<int> totalWorkSeconds = GeneratedColumn<int>(
      'total_work_seconds', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (total_work_seconds >= 0 AND total_work_seconds < 60)');
  static const VerificationMeta _totalRestMinutesMeta =
      const VerificationMeta('totalRestMinutes');
  @override
  late final GeneratedColumn<int> totalRestMinutes = GeneratedColumn<int>(
      'total_rest_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (total_rest_minutes >= 0 AND total_rest_minutes < 60)');
  static const VerificationMeta _totalRestSecondsMeta =
      const VerificationMeta('totalRestSeconds');
  @override
  late final GeneratedColumn<int> totalRestSeconds = GeneratedColumn<int>(
      'total_rest_seconds', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (total_rest_seconds >= 0 AND total_rest_seconds < 60)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        totalWorkMinutes,
        totalWorkSeconds,
        totalRestMinutes,
        totalRestSeconds
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timer_table';
  @override
  VerificationContext validateIntegrity(Insertable<TimerTableData> instance,
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
    if (data.containsKey('total_work_minutes')) {
      context.handle(
          _totalWorkMinutesMeta,
          totalWorkMinutes.isAcceptableOrUnknown(
              data['total_work_minutes']!, _totalWorkMinutesMeta));
    } else if (isInserting) {
      context.missing(_totalWorkMinutesMeta);
    }
    if (data.containsKey('total_work_seconds')) {
      context.handle(
          _totalWorkSecondsMeta,
          totalWorkSeconds.isAcceptableOrUnknown(
              data['total_work_seconds']!, _totalWorkSecondsMeta));
    } else if (isInserting) {
      context.missing(_totalWorkSecondsMeta);
    }
    if (data.containsKey('total_rest_minutes')) {
      context.handle(
          _totalRestMinutesMeta,
          totalRestMinutes.isAcceptableOrUnknown(
              data['total_rest_minutes']!, _totalRestMinutesMeta));
    } else if (isInserting) {
      context.missing(_totalRestMinutesMeta);
    }
    if (data.containsKey('total_rest_seconds')) {
      context.handle(
          _totalRestSecondsMeta,
          totalRestSeconds.isAcceptableOrUnknown(
              data['total_rest_seconds']!, _totalRestSecondsMeta));
    } else if (isInserting) {
      context.missing(_totalRestSecondsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimerTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      totalWorkMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_work_minutes'])!,
      totalWorkSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_work_seconds'])!,
      totalRestMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_rest_minutes'])!,
      totalRestSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_rest_seconds'])!,
    );
  }

  @override
  $TimerTableTable createAlias(String alias) {
    return $TimerTableTable(attachedDatabase, alias);
  }
}

class TimerTableData extends DataClass implements Insertable<TimerTableData> {
  final int id;
  final String name;
  final int totalWorkMinutes;
  final int totalWorkSeconds;
  final int totalRestMinutes;
  final int totalRestSeconds;
  const TimerTableData(
      {required this.id,
      required this.name,
      required this.totalWorkMinutes,
      required this.totalWorkSeconds,
      required this.totalRestMinutes,
      required this.totalRestSeconds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['total_work_minutes'] = Variable<int>(totalWorkMinutes);
    map['total_work_seconds'] = Variable<int>(totalWorkSeconds);
    map['total_rest_minutes'] = Variable<int>(totalRestMinutes);
    map['total_rest_seconds'] = Variable<int>(totalRestSeconds);
    return map;
  }

  TimerTableCompanion toCompanion(bool nullToAbsent) {
    return TimerTableCompanion(
      id: Value(id),
      name: Value(name),
      totalWorkMinutes: Value(totalWorkMinutes),
      totalWorkSeconds: Value(totalWorkSeconds),
      totalRestMinutes: Value(totalRestMinutes),
      totalRestSeconds: Value(totalRestSeconds),
    );
  }

  factory TimerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimerTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      totalWorkMinutes: serializer.fromJson<int>(json['totalWorkMinutes']),
      totalWorkSeconds: serializer.fromJson<int>(json['totalWorkSeconds']),
      totalRestMinutes: serializer.fromJson<int>(json['totalRestMinutes']),
      totalRestSeconds: serializer.fromJson<int>(json['totalRestSeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'totalWorkMinutes': serializer.toJson<int>(totalWorkMinutes),
      'totalWorkSeconds': serializer.toJson<int>(totalWorkSeconds),
      'totalRestMinutes': serializer.toJson<int>(totalRestMinutes),
      'totalRestSeconds': serializer.toJson<int>(totalRestSeconds),
    };
  }

  TimerTableData copyWith(
          {int? id,
          String? name,
          int? totalWorkMinutes,
          int? totalWorkSeconds,
          int? totalRestMinutes,
          int? totalRestSeconds}) =>
      TimerTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        totalWorkMinutes: totalWorkMinutes ?? this.totalWorkMinutes,
        totalWorkSeconds: totalWorkSeconds ?? this.totalWorkSeconds,
        totalRestMinutes: totalRestMinutes ?? this.totalRestMinutes,
        totalRestSeconds: totalRestSeconds ?? this.totalRestSeconds,
      );
  TimerTableData copyWithCompanion(TimerTableCompanion data) {
    return TimerTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      totalWorkMinutes: data.totalWorkMinutes.present
          ? data.totalWorkMinutes.value
          : this.totalWorkMinutes,
      totalWorkSeconds: data.totalWorkSeconds.present
          ? data.totalWorkSeconds.value
          : this.totalWorkSeconds,
      totalRestMinutes: data.totalRestMinutes.present
          ? data.totalRestMinutes.value
          : this.totalRestMinutes,
      totalRestSeconds: data.totalRestSeconds.present
          ? data.totalRestSeconds.value
          : this.totalRestSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimerTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('totalWorkMinutes: $totalWorkMinutes, ')
          ..write('totalWorkSeconds: $totalWorkSeconds, ')
          ..write('totalRestMinutes: $totalRestMinutes, ')
          ..write('totalRestSeconds: $totalRestSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, totalWorkMinutes, totalWorkSeconds,
      totalRestMinutes, totalRestSeconds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.totalWorkMinutes == this.totalWorkMinutes &&
          other.totalWorkSeconds == this.totalWorkSeconds &&
          other.totalRestMinutes == this.totalRestMinutes &&
          other.totalRestSeconds == this.totalRestSeconds);
}

class TimerTableCompanion extends UpdateCompanion<TimerTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> totalWorkMinutes;
  final Value<int> totalWorkSeconds;
  final Value<int> totalRestMinutes;
  final Value<int> totalRestSeconds;
  const TimerTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.totalWorkMinutes = const Value.absent(),
    this.totalWorkSeconds = const Value.absent(),
    this.totalRestMinutes = const Value.absent(),
    this.totalRestSeconds = const Value.absent(),
  });
  TimerTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int totalWorkMinutes,
    required int totalWorkSeconds,
    required int totalRestMinutes,
    required int totalRestSeconds,
  })  : name = Value(name),
        totalWorkMinutes = Value(totalWorkMinutes),
        totalWorkSeconds = Value(totalWorkSeconds),
        totalRestMinutes = Value(totalRestMinutes),
        totalRestSeconds = Value(totalRestSeconds);
  static Insertable<TimerTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? totalWorkMinutes,
    Expression<int>? totalWorkSeconds,
    Expression<int>? totalRestMinutes,
    Expression<int>? totalRestSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (totalWorkMinutes != null) 'total_work_minutes': totalWorkMinutes,
      if (totalWorkSeconds != null) 'total_work_seconds': totalWorkSeconds,
      if (totalRestMinutes != null) 'total_rest_minutes': totalRestMinutes,
      if (totalRestSeconds != null) 'total_rest_seconds': totalRestSeconds,
    });
  }

  TimerTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? totalWorkMinutes,
      Value<int>? totalWorkSeconds,
      Value<int>? totalRestMinutes,
      Value<int>? totalRestSeconds}) {
    return TimerTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      totalWorkMinutes: totalWorkMinutes ?? this.totalWorkMinutes,
      totalWorkSeconds: totalWorkSeconds ?? this.totalWorkSeconds,
      totalRestMinutes: totalRestMinutes ?? this.totalRestMinutes,
      totalRestSeconds: totalRestSeconds ?? this.totalRestSeconds,
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
    if (totalWorkMinutes.present) {
      map['total_work_minutes'] = Variable<int>(totalWorkMinutes.value);
    }
    if (totalWorkSeconds.present) {
      map['total_work_seconds'] = Variable<int>(totalWorkSeconds.value);
    }
    if (totalRestMinutes.present) {
      map['total_rest_minutes'] = Variable<int>(totalRestMinutes.value);
    }
    if (totalRestSeconds.present) {
      map['total_rest_seconds'] = Variable<int>(totalRestSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimerTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('totalWorkMinutes: $totalWorkMinutes, ')
          ..write('totalWorkSeconds: $totalWorkSeconds, ')
          ..write('totalRestMinutes: $totalRestMinutes, ')
          ..write('totalRestSeconds: $totalRestSeconds')
          ..write(')'))
        .toString();
  }
}

abstract class _$TimerDriftDatabase extends GeneratedDatabase {
  _$TimerDriftDatabase(QueryExecutor e) : super(e);
  $TimerDriftDatabaseManager get managers => $TimerDriftDatabaseManager(this);
  late final $TimerTableTable timerTable = $TimerTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [timerTable];
}

typedef $$TimerTableTableCreateCompanionBuilder = TimerTableCompanion Function({
  Value<int> id,
  required String name,
  required int totalWorkMinutes,
  required int totalWorkSeconds,
  required int totalRestMinutes,
  required int totalRestSeconds,
});
typedef $$TimerTableTableUpdateCompanionBuilder = TimerTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> totalWorkMinutes,
  Value<int> totalWorkSeconds,
  Value<int> totalRestMinutes,
  Value<int> totalRestSeconds,
});

class $$TimerTableTableFilterComposer
    extends Composer<_$TimerDriftDatabase, $TimerTableTable> {
  $$TimerTableTableFilterComposer({
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

  ColumnFilters<int> get totalWorkMinutes => $composableBuilder(
      column: $table.totalWorkMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalWorkSeconds => $composableBuilder(
      column: $table.totalWorkSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalRestMinutes => $composableBuilder(
      column: $table.totalRestMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalRestSeconds => $composableBuilder(
      column: $table.totalRestSeconds,
      builder: (column) => ColumnFilters(column));
}

class $$TimerTableTableOrderingComposer
    extends Composer<_$TimerDriftDatabase, $TimerTableTable> {
  $$TimerTableTableOrderingComposer({
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

  ColumnOrderings<int> get totalWorkMinutes => $composableBuilder(
      column: $table.totalWorkMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalWorkSeconds => $composableBuilder(
      column: $table.totalWorkSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalRestMinutes => $composableBuilder(
      column: $table.totalRestMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalRestSeconds => $composableBuilder(
      column: $table.totalRestSeconds,
      builder: (column) => ColumnOrderings(column));
}

class $$TimerTableTableAnnotationComposer
    extends Composer<_$TimerDriftDatabase, $TimerTableTable> {
  $$TimerTableTableAnnotationComposer({
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

  GeneratedColumn<int> get totalWorkMinutes => $composableBuilder(
      column: $table.totalWorkMinutes, builder: (column) => column);

  GeneratedColumn<int> get totalWorkSeconds => $composableBuilder(
      column: $table.totalWorkSeconds, builder: (column) => column);

  GeneratedColumn<int> get totalRestMinutes => $composableBuilder(
      column: $table.totalRestMinutes, builder: (column) => column);

  GeneratedColumn<int> get totalRestSeconds => $composableBuilder(
      column: $table.totalRestSeconds, builder: (column) => column);
}

class $$TimerTableTableTableManager extends RootTableManager<
    _$TimerDriftDatabase,
    $TimerTableTable,
    TimerTableData,
    $$TimerTableTableFilterComposer,
    $$TimerTableTableOrderingComposer,
    $$TimerTableTableAnnotationComposer,
    $$TimerTableTableCreateCompanionBuilder,
    $$TimerTableTableUpdateCompanionBuilder,
    (
      TimerTableData,
      BaseReferences<_$TimerDriftDatabase, $TimerTableTable, TimerTableData>
    ),
    TimerTableData,
    PrefetchHooks Function()> {
  $$TimerTableTableTableManager(_$TimerDriftDatabase db, $TimerTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimerTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimerTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> totalWorkMinutes = const Value.absent(),
            Value<int> totalWorkSeconds = const Value.absent(),
            Value<int> totalRestMinutes = const Value.absent(),
            Value<int> totalRestSeconds = const Value.absent(),
          }) =>
              TimerTableCompanion(
            id: id,
            name: name,
            totalWorkMinutes: totalWorkMinutes,
            totalWorkSeconds: totalWorkSeconds,
            totalRestMinutes: totalRestMinutes,
            totalRestSeconds: totalRestSeconds,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int totalWorkMinutes,
            required int totalWorkSeconds,
            required int totalRestMinutes,
            required int totalRestSeconds,
          }) =>
              TimerTableCompanion.insert(
            id: id,
            name: name,
            totalWorkMinutes: totalWorkMinutes,
            totalWorkSeconds: totalWorkSeconds,
            totalRestMinutes: totalRestMinutes,
            totalRestSeconds: totalRestSeconds,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TimerTableTableProcessedTableManager = ProcessedTableManager<
    _$TimerDriftDatabase,
    $TimerTableTable,
    TimerTableData,
    $$TimerTableTableFilterComposer,
    $$TimerTableTableOrderingComposer,
    $$TimerTableTableAnnotationComposer,
    $$TimerTableTableCreateCompanionBuilder,
    $$TimerTableTableUpdateCompanionBuilder,
    (
      TimerTableData,
      BaseReferences<_$TimerDriftDatabase, $TimerTableTable, TimerTableData>
    ),
    TimerTableData,
    PrefetchHooks Function()>;

class $TimerDriftDatabaseManager {
  final _$TimerDriftDatabase _db;
  $TimerDriftDatabaseManager(this._db);
  $$TimerTableTableTableManager get timerTable =>
      $$TimerTableTableTableManager(_db, _db.timerTable);
}
