// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimerCollection on Isar {
  IsarCollection<Timer> get timers => this.collection();
}

const TimerSchema = CollectionSchema(
  name: r'Timer',
  id: 3422435319111787164,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'totalRestMinutes': PropertySchema(
      id: 2,
      name: r'totalRestMinutes',
      type: IsarType.long,
    ),
    r'totalRestSeconds': PropertySchema(
      id: 3,
      name: r'totalRestSeconds',
      type: IsarType.long,
    ),
    r'totalWorkMinutes': PropertySchema(
      id: 4,
      name: r'totalWorkMinutes',
      type: IsarType.long,
    ),
    r'totalWorkSeconds': PropertySchema(
      id: 5,
      name: r'totalWorkSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _timerEstimateSize,
  serialize: _timerSerialize,
  deserialize: _timerDeserialize,
  deserializeProp: _timerDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _timerGetId,
  getLinks: _timerGetLinks,
  attach: _timerAttach,
  version: '3.1.0+1',
);

int _timerEstimateSize(
  Timer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _timerSerialize(
  Timer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeString(offsets[1], object.name);
  writer.writeLong(offsets[2], object.totalRestMinutes);
  writer.writeLong(offsets[3], object.totalRestSeconds);
  writer.writeLong(offsets[4], object.totalWorkMinutes);
  writer.writeLong(offsets[5], object.totalWorkSeconds);
}

Timer _timerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Timer(
    name: reader.readString(offsets[1]),
    totalRestMinutes: reader.readLongOrNull(offsets[2]) ?? 5,
    totalRestSeconds: reader.readLongOrNull(offsets[3]) ?? 0,
    totalWorkMinutes: reader.readLongOrNull(offsets[4]) ?? 25,
    totalWorkSeconds: reader.readLongOrNull(offsets[5]) ?? 0,
  );
  object.id = id;
  return object;
}

P _timerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 25) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timerGetId(Timer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timerGetLinks(Timer object) {
  return [];
}

void _timerAttach(IsarCollection<dynamic> col, Id id, Timer object) {
  object.id = id;
}

extension TimerByIndex on IsarCollection<Timer> {
  Future<Timer?> getByName(String name) {
    return getByIndex(r'name', [name]);
  }

  Timer? getByNameSync(String name) {
    return getByIndexSync(r'name', [name]);
  }

  Future<bool> deleteByName(String name) {
    return deleteByIndex(r'name', [name]);
  }

  bool deleteByNameSync(String name) {
    return deleteByIndexSync(r'name', [name]);
  }

  Future<List<Timer?>> getAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex(r'name', values);
  }

  List<Timer?> getAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'name', values);
  }

  Future<int> deleteAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'name', values);
  }

  int deleteAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'name', values);
  }

  Future<Id> putByName(Timer object) {
    return putByIndex(r'name', object);
  }

  Id putByNameSync(Timer object, {bool saveLinks = true}) {
    return putByIndexSync(r'name', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByName(List<Timer> objects) {
    return putAllByIndex(r'name', objects);
  }

  List<Id> putAllByNameSync(List<Timer> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'name', objects, saveLinks: saveLinks);
  }
}

extension TimerQueryWhereSort on QueryBuilder<Timer, Timer, QWhere> {
  QueryBuilder<Timer, Timer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimerQueryWhere on QueryBuilder<Timer, Timer, QWhereClause> {
  QueryBuilder<Timer, Timer, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Timer, Timer, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Timer, Timer, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Timer, Timer, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterWhereClause> nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TimerQueryFilter on QueryBuilder<Timer, Timer, QFilterCondition> {
  QueryBuilder<Timer, Timer, QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalRestMinutesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalRestMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalRestMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalRestMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalRestMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalRestMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalRestMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalRestMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalRestSecondsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalRestSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalRestSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalRestSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalRestSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalRestSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalRestSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalRestSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalWorkMinutesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalWorkMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalWorkMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalWorkMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalWorkMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalWorkMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalWorkMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalWorkMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalWorkSecondsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalWorkSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalWorkSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalWorkSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalWorkSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalWorkSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<Timer, Timer, QAfterFilterCondition> totalWorkSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalWorkSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimerQueryObject on QueryBuilder<Timer, Timer, QFilterCondition> {}

extension TimerQueryLinks on QueryBuilder<Timer, Timer, QFilterCondition> {}

extension TimerQuerySortBy on QueryBuilder<Timer, Timer, QSortBy> {
  QueryBuilder<Timer, Timer, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByTotalRestMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRestMinutes', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByTotalRestMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRestMinutes', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByTotalRestSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRestSeconds', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByTotalRestSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRestSeconds', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByTotalWorkMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWorkMinutes', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByTotalWorkMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWorkMinutes', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByTotalWorkSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWorkSeconds', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> sortByTotalWorkSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWorkSeconds', Sort.desc);
    });
  }
}

extension TimerQuerySortThenBy on QueryBuilder<Timer, Timer, QSortThenBy> {
  QueryBuilder<Timer, Timer, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByTotalRestMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRestMinutes', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByTotalRestMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRestMinutes', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByTotalRestSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRestSeconds', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByTotalRestSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRestSeconds', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByTotalWorkMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWorkMinutes', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByTotalWorkMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWorkMinutes', Sort.desc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByTotalWorkSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWorkSeconds', Sort.asc);
    });
  }

  QueryBuilder<Timer, Timer, QAfterSortBy> thenByTotalWorkSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWorkSeconds', Sort.desc);
    });
  }
}

extension TimerQueryWhereDistinct on QueryBuilder<Timer, Timer, QDistinct> {
  QueryBuilder<Timer, Timer, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<Timer, Timer, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Timer, Timer, QDistinct> distinctByTotalRestMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalRestMinutes');
    });
  }

  QueryBuilder<Timer, Timer, QDistinct> distinctByTotalRestSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalRestSeconds');
    });
  }

  QueryBuilder<Timer, Timer, QDistinct> distinctByTotalWorkMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalWorkMinutes');
    });
  }

  QueryBuilder<Timer, Timer, QDistinct> distinctByTotalWorkSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalWorkSeconds');
    });
  }
}

extension TimerQueryProperty on QueryBuilder<Timer, Timer, QQueryProperty> {
  QueryBuilder<Timer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Timer, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<Timer, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Timer, int, QQueryOperations> totalRestMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalRestMinutes');
    });
  }

  QueryBuilder<Timer, int, QQueryOperations> totalRestSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalRestSeconds');
    });
  }

  QueryBuilder<Timer, int, QQueryOperations> totalWorkMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalWorkMinutes');
    });
  }

  QueryBuilder<Timer, int, QQueryOperations> totalWorkSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalWorkSeconds');
    });
  }
}
