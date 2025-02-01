// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $CategoryColorsTable extends CategoryColors
    with TableInfo<$CategoryColorsTable, CategoryColor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryColorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_colors';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryColor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryColor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryColor(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
    );
  }

  @override
  $CategoryColorsTable createAlias(String alias) {
    return $CategoryColorsTable(attachedDatabase, alias);
  }
}

class CategoryColor extends DataClass implements Insertable<CategoryColor> {
  final int id;
  final String color;
  const CategoryColor({required this.id, required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['color'] = Variable<String>(color);
    return map;
  }

  CategoryColorsCompanion toCompanion(bool nullToAbsent) {
    return CategoryColorsCompanion(
      id: Value(id),
      color: Value(color),
    );
  }

  factory CategoryColor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryColor(
      id: serializer.fromJson<int>(json['id']),
      color: serializer.fromJson<String>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'color': serializer.toJson<String>(color),
    };
  }

  CategoryColor copyWith({int? id, String? color}) => CategoryColor(
        id: id ?? this.id,
        color: color ?? this.color,
      );
  CategoryColor copyWithCompanion(CategoryColorsCompanion data) {
    return CategoryColor(
      id: data.id.present ? data.id.value : this.id,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryColor(')
          ..write('id: $id, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryColor &&
          other.id == this.id &&
          other.color == this.color);
}

class CategoryColorsCompanion extends UpdateCompanion<CategoryColor> {
  final Value<int> id;
  final Value<String> color;
  const CategoryColorsCompanion({
    this.id = const Value.absent(),
    this.color = const Value.absent(),
  });
  CategoryColorsCompanion.insert({
    this.id = const Value.absent(),
    required String color,
  }) : color = Value(color);
  static Insertable<CategoryColor> custom({
    Expression<int>? id,
    Expression<String>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (color != null) 'color': color,
    });
  }

  CategoryColorsCompanion copyWith({Value<int>? id, Value<String>? color}) {
    return CategoryColorsCompanion(
      id: id ?? this.id,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryColorsCompanion(')
          ..write('id: $id, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $ScheduleItemsTable extends ScheduleItems
    with TableInfo<$ScheduleItemsTable, ScheduleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<int> startTime = GeneratedColumn<int>(
      'start_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<int> endTime = GeneratedColumn<int>(
      'end_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _categoryColorIdMeta =
      const VerificationMeta('categoryColorId');
  @override
  late final GeneratedColumn<int> categoryColorId = GeneratedColumn<int>(
      'category_color_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES category_colors (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, startTime, endTime, content, date, categoryColorId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_items';
  @override
  VerificationContext validateIntegrity(Insertable<ScheduleItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('category_color_id')) {
      context.handle(
          _categoryColorIdMeta,
          categoryColorId.isAcceptableOrUnknown(
              data['category_color_id']!, _categoryColorIdMeta));
    } else if (isInserting) {
      context.missing(_categoryColorIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      categoryColorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_color_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ScheduleItemsTable createAlias(String alias) {
    return $ScheduleItemsTable(attachedDatabase, alias);
  }
}

class ScheduleItem extends DataClass implements Insertable<ScheduleItem> {
  final int id;
  final int startTime;
  final int endTime;
  final String content;
  final DateTime date;
  final int categoryColorId;
  final DateTime createdAt;
  const ScheduleItem(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.content,
      required this.date,
      required this.categoryColorId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_time'] = Variable<int>(startTime);
    map['end_time'] = Variable<int>(endTime);
    map['content'] = Variable<String>(content);
    map['date'] = Variable<DateTime>(date);
    map['category_color_id'] = Variable<int>(categoryColorId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ScheduleItemsCompanion toCompanion(bool nullToAbsent) {
    return ScheduleItemsCompanion(
      id: Value(id),
      startTime: Value(startTime),
      endTime: Value(endTime),
      content: Value(content),
      date: Value(date),
      categoryColorId: Value(categoryColorId),
      createdAt: Value(createdAt),
    );
  }

  factory ScheduleItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleItem(
      id: serializer.fromJson<int>(json['id']),
      startTime: serializer.fromJson<int>(json['startTime']),
      endTime: serializer.fromJson<int>(json['endTime']),
      content: serializer.fromJson<String>(json['content']),
      date: serializer.fromJson<DateTime>(json['date']),
      categoryColorId: serializer.fromJson<int>(json['categoryColorId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startTime': serializer.toJson<int>(startTime),
      'endTime': serializer.toJson<int>(endTime),
      'content': serializer.toJson<String>(content),
      'date': serializer.toJson<DateTime>(date),
      'categoryColorId': serializer.toJson<int>(categoryColorId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ScheduleItem copyWith(
          {int? id,
          int? startTime,
          int? endTime,
          String? content,
          DateTime? date,
          int? categoryColorId,
          DateTime? createdAt}) =>
      ScheduleItem(
        id: id ?? this.id,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        content: content ?? this.content,
        date: date ?? this.date,
        categoryColorId: categoryColorId ?? this.categoryColorId,
        createdAt: createdAt ?? this.createdAt,
      );
  ScheduleItem copyWithCompanion(ScheduleItemsCompanion data) {
    return ScheduleItem(
      id: data.id.present ? data.id.value : this.id,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      content: data.content.present ? data.content.value : this.content,
      date: data.date.present ? data.date.value : this.date,
      categoryColorId: data.categoryColorId.present
          ? data.categoryColorId.value
          : this.categoryColorId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleItem(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('content: $content, ')
          ..write('date: $date, ')
          ..write('categoryColorId: $categoryColorId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, startTime, endTime, content, date, categoryColorId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleItem &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.content == this.content &&
          other.date == this.date &&
          other.categoryColorId == this.categoryColorId &&
          other.createdAt == this.createdAt);
}

class ScheduleItemsCompanion extends UpdateCompanion<ScheduleItem> {
  final Value<int> id;
  final Value<int> startTime;
  final Value<int> endTime;
  final Value<String> content;
  final Value<DateTime> date;
  final Value<int> categoryColorId;
  final Value<DateTime> createdAt;
  const ScheduleItemsCompanion({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.content = const Value.absent(),
    this.date = const Value.absent(),
    this.categoryColorId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ScheduleItemsCompanion.insert({
    this.id = const Value.absent(),
    required int startTime,
    required int endTime,
    required String content,
    required DateTime date,
    required int categoryColorId,
    this.createdAt = const Value.absent(),
  })  : startTime = Value(startTime),
        endTime = Value(endTime),
        content = Value(content),
        date = Value(date),
        categoryColorId = Value(categoryColorId);
  static Insertable<ScheduleItem> custom({
    Expression<int>? id,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<String>? content,
    Expression<DateTime>? date,
    Expression<int>? categoryColorId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (content != null) 'content': content,
      if (date != null) 'date': date,
      if (categoryColorId != null) 'category_color_id': categoryColorId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ScheduleItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? startTime,
      Value<int>? endTime,
      Value<String>? content,
      Value<DateTime>? date,
      Value<int>? categoryColorId,
      Value<DateTime>? createdAt}) {
    return ScheduleItemsCompanion(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      content: content ?? this.content,
      date: date ?? this.date,
      categoryColorId: categoryColorId ?? this.categoryColorId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(endTime.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (categoryColorId.present) {
      map['category_color_id'] = Variable<int>(categoryColorId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleItemsCompanion(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('content: $content, ')
          ..write('date: $date, ')
          ..write('categoryColorId: $categoryColorId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoryColorsTable categoryColors = $CategoryColorsTable(this);
  late final $ScheduleItemsTable scheduleItems = $ScheduleItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categoryColors, scheduleItems];
}

typedef $$CategoryColorsTableCreateCompanionBuilder = CategoryColorsCompanion
    Function({
  Value<int> id,
  required String color,
});
typedef $$CategoryColorsTableUpdateCompanionBuilder = CategoryColorsCompanion
    Function({
  Value<int> id,
  Value<String> color,
});

final class $$CategoryColorsTableReferences
    extends BaseReferences<_$AppDatabase, $CategoryColorsTable, CategoryColor> {
  $$CategoryColorsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ScheduleItemsTable, List<ScheduleItem>>
      _scheduleItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.scheduleItems,
              aliasName: $_aliasNameGenerator(
                  db.categoryColors.id, db.scheduleItems.categoryColorId));

  $$ScheduleItemsTableProcessedTableManager get scheduleItemsRefs {
    final manager = $$ScheduleItemsTableTableManager($_db, $_db.scheduleItems)
        .filter((f) => f.categoryColorId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_scheduleItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoryColorsTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryColorsTable> {
  $$CategoryColorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  Expression<bool> scheduleItemsRefs(
      Expression<bool> Function($$ScheduleItemsTableFilterComposer f) f) {
    final $$ScheduleItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.scheduleItems,
        getReferencedColumn: (t) => t.categoryColorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScheduleItemsTableFilterComposer(
              $db: $db,
              $table: $db.scheduleItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryColorsTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryColorsTable> {
  $$CategoryColorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));
}

class $$CategoryColorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryColorsTable> {
  $$CategoryColorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  Expression<T> scheduleItemsRefs<T extends Object>(
      Expression<T> Function($$ScheduleItemsTableAnnotationComposer a) f) {
    final $$ScheduleItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.scheduleItems,
        getReferencedColumn: (t) => t.categoryColorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScheduleItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.scheduleItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryColorsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryColorsTable,
    CategoryColor,
    $$CategoryColorsTableFilterComposer,
    $$CategoryColorsTableOrderingComposer,
    $$CategoryColorsTableAnnotationComposer,
    $$CategoryColorsTableCreateCompanionBuilder,
    $$CategoryColorsTableUpdateCompanionBuilder,
    (CategoryColor, $$CategoryColorsTableReferences),
    CategoryColor,
    PrefetchHooks Function({bool scheduleItemsRefs})> {
  $$CategoryColorsTableTableManager(
      _$AppDatabase db, $CategoryColorsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryColorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryColorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryColorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> color = const Value.absent(),
          }) =>
              CategoryColorsCompanion(
            id: id,
            color: color,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String color,
          }) =>
              CategoryColorsCompanion.insert(
            id: id,
            color: color,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoryColorsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({scheduleItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (scheduleItemsRefs) db.scheduleItems
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scheduleItemsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CategoryColorsTableReferences
                            ._scheduleItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoryColorsTableReferences(db, table, p0)
                                .scheduleItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryColorId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoryColorsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryColorsTable,
    CategoryColor,
    $$CategoryColorsTableFilterComposer,
    $$CategoryColorsTableOrderingComposer,
    $$CategoryColorsTableAnnotationComposer,
    $$CategoryColorsTableCreateCompanionBuilder,
    $$CategoryColorsTableUpdateCompanionBuilder,
    (CategoryColor, $$CategoryColorsTableReferences),
    CategoryColor,
    PrefetchHooks Function({bool scheduleItemsRefs})>;
typedef $$ScheduleItemsTableCreateCompanionBuilder = ScheduleItemsCompanion
    Function({
  Value<int> id,
  required int startTime,
  required int endTime,
  required String content,
  required DateTime date,
  required int categoryColorId,
  Value<DateTime> createdAt,
});
typedef $$ScheduleItemsTableUpdateCompanionBuilder = ScheduleItemsCompanion
    Function({
  Value<int> id,
  Value<int> startTime,
  Value<int> endTime,
  Value<String> content,
  Value<DateTime> date,
  Value<int> categoryColorId,
  Value<DateTime> createdAt,
});

final class $$ScheduleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ScheduleItemsTable, ScheduleItem> {
  $$ScheduleItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoryColorsTable _categoryColorIdTable(_$AppDatabase db) =>
      db.categoryColors.createAlias($_aliasNameGenerator(
          db.scheduleItems.categoryColorId, db.categoryColors.id));

  $$CategoryColorsTableProcessedTableManager get categoryColorId {
    final manager = $$CategoryColorsTableTableManager($_db, $_db.categoryColors)
        .filter((f) => f.id($_item.categoryColorId));
    final item = $_typedResult.readTableOrNull(_categoryColorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ScheduleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleItemsTable> {
  $$ScheduleItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CategoryColorsTableFilterComposer get categoryColorId {
    final $$CategoryColorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryColorId,
        referencedTable: $db.categoryColors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryColorsTableFilterComposer(
              $db: $db,
              $table: $db.categoryColors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ScheduleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleItemsTable> {
  $$ScheduleItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CategoryColorsTableOrderingComposer get categoryColorId {
    final $$CategoryColorsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryColorId,
        referencedTable: $db.categoryColors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryColorsTableOrderingComposer(
              $db: $db,
              $table: $db.categoryColors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ScheduleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleItemsTable> {
  $$ScheduleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<int> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CategoryColorsTableAnnotationComposer get categoryColorId {
    final $$CategoryColorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryColorId,
        referencedTable: $db.categoryColors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryColorsTableAnnotationComposer(
              $db: $db,
              $table: $db.categoryColors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ScheduleItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScheduleItemsTable,
    ScheduleItem,
    $$ScheduleItemsTableFilterComposer,
    $$ScheduleItemsTableOrderingComposer,
    $$ScheduleItemsTableAnnotationComposer,
    $$ScheduleItemsTableCreateCompanionBuilder,
    $$ScheduleItemsTableUpdateCompanionBuilder,
    (ScheduleItem, $$ScheduleItemsTableReferences),
    ScheduleItem,
    PrefetchHooks Function({bool categoryColorId})> {
  $$ScheduleItemsTableTableManager(_$AppDatabase db, $ScheduleItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> startTime = const Value.absent(),
            Value<int> endTime = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> categoryColorId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ScheduleItemsCompanion(
            id: id,
            startTime: startTime,
            endTime: endTime,
            content: content,
            date: date,
            categoryColorId: categoryColorId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int startTime,
            required int endTime,
            required String content,
            required DateTime date,
            required int categoryColorId,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ScheduleItemsCompanion.insert(
            id: id,
            startTime: startTime,
            endTime: endTime,
            content: content,
            date: date,
            categoryColorId: categoryColorId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ScheduleItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryColorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryColorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryColorId,
                    referencedTable: $$ScheduleItemsTableReferences
                        ._categoryColorIdTable(db),
                    referencedColumn: $$ScheduleItemsTableReferences
                        ._categoryColorIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ScheduleItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScheduleItemsTable,
    ScheduleItem,
    $$ScheduleItemsTableFilterComposer,
    $$ScheduleItemsTableOrderingComposer,
    $$ScheduleItemsTableAnnotationComposer,
    $$ScheduleItemsTableCreateCompanionBuilder,
    $$ScheduleItemsTableUpdateCompanionBuilder,
    (ScheduleItem, $$ScheduleItemsTableReferences),
    ScheduleItem,
    PrefetchHooks Function({bool categoryColorId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoryColorsTableTableManager get categoryColors =>
      $$CategoryColorsTableTableManager(_db, _db.categoryColors);
  $$ScheduleItemsTableTableManager get scheduleItems =>
      $$ScheduleItemsTableTableManager(_db, _db.scheduleItems);
}
