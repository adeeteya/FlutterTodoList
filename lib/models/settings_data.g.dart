// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSettingsDataCollection on Isar {
  IsarCollection<SettingsData> get settingsDatas => this.collection();
}

const SettingsDataSchema = CollectionSchema(
  name: r'SettingsData',
  id: -966610349317306745,
  properties: {
    r'colorValue': PropertySchema(
      id: 0,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'isDarkTheme': PropertySchema(
      id: 1,
      name: r'isDarkTheme',
      type: IsarType.bool,
    )
  },
  estimateSize: _settingsDataEstimateSize,
  serialize: _settingsDataSerialize,
  deserialize: _settingsDataDeserialize,
  deserializeProp: _settingsDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _settingsDataGetId,
  getLinks: _settingsDataGetLinks,
  attach: _settingsDataAttach,
  version: '3.1.0+1',
);

int _settingsDataEstimateSize(
  SettingsData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _settingsDataSerialize(
  SettingsData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.colorValue);
  writer.writeBool(offsets[1], object.isDarkTheme);
}

SettingsData _settingsDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SettingsData(
    reader.readBool(offsets[1]),
    reader.readLong(offsets[0]),
  );
  return object;
}

P _settingsDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _settingsDataGetId(SettingsData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _settingsDataGetLinks(SettingsData object) {
  return [];
}

void _settingsDataAttach(
    IsarCollection<dynamic> col, Id id, SettingsData object) {}

extension SettingsDataQueryWhereSort
    on QueryBuilder<SettingsData, SettingsData, QWhere> {
  QueryBuilder<SettingsData, SettingsData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SettingsDataQueryWhere
    on QueryBuilder<SettingsData, SettingsData, QWhereClause> {
  QueryBuilder<SettingsData, SettingsData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SettingsData, SettingsData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterWhereClause> idBetween(
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
}

extension SettingsDataQueryFilter
    on QueryBuilder<SettingsData, SettingsData, QFilterCondition> {
  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition>
      colorValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition>
      colorValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition>
      colorValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition>
      colorValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SettingsData, SettingsData, QAfterFilterCondition>
      isDarkThemeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDarkTheme',
        value: value,
      ));
    });
  }
}

extension SettingsDataQueryObject
    on QueryBuilder<SettingsData, SettingsData, QFilterCondition> {}

extension SettingsDataQueryLinks
    on QueryBuilder<SettingsData, SettingsData, QFilterCondition> {}

extension SettingsDataQuerySortBy
    on QueryBuilder<SettingsData, SettingsData, QSortBy> {
  QueryBuilder<SettingsData, SettingsData, QAfterSortBy> sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterSortBy>
      sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterSortBy> sortByIsDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkTheme', Sort.asc);
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterSortBy>
      sortByIsDarkThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkTheme', Sort.desc);
    });
  }
}

extension SettingsDataQuerySortThenBy
    on QueryBuilder<SettingsData, SettingsData, QSortThenBy> {
  QueryBuilder<SettingsData, SettingsData, QAfterSortBy> thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterSortBy>
      thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterSortBy> thenByIsDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkTheme', Sort.asc);
    });
  }

  QueryBuilder<SettingsData, SettingsData, QAfterSortBy>
      thenByIsDarkThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkTheme', Sort.desc);
    });
  }
}

extension SettingsDataQueryWhereDistinct
    on QueryBuilder<SettingsData, SettingsData, QDistinct> {
  QueryBuilder<SettingsData, SettingsData, QDistinct> distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorValue');
    });
  }

  QueryBuilder<SettingsData, SettingsData, QDistinct> distinctByIsDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDarkTheme');
    });
  }
}

extension SettingsDataQueryProperty
    on QueryBuilder<SettingsData, SettingsData, QQueryProperty> {
  QueryBuilder<SettingsData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SettingsData, int, QQueryOperations> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorValue');
    });
  }

  QueryBuilder<SettingsData, bool, QQueryOperations> isDarkThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDarkTheme');
    });
  }
}
