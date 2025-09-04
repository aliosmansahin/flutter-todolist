// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateAndTimeMeta = const VerificationMeta(
    'dateAndTime',
  );
  @override
  late final GeneratedColumn<DateTime> dateAndTime = GeneratedColumn<DateTime>(
    'date_and_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shouldNotifyMeta = const VerificationMeta(
    'shouldNotify',
  );
  @override
  late final GeneratedColumn<bool> shouldNotify = GeneratedColumn<bool>(
    'should_notify',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("should_notify" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notificationSentMeta = const VerificationMeta(
    'notificationSent',
  );
  @override
  late final GeneratedColumn<bool> notificationSent = GeneratedColumn<bool>(
    'notification_sent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notification_sent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    dateAndTime,
    type,
    shouldNotify,
    notificationSent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date_and_time')) {
      context.handle(
        _dateAndTimeMeta,
        dateAndTime.isAcceptableOrUnknown(
          data['date_and_time']!,
          _dateAndTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateAndTimeMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('should_notify')) {
      context.handle(
        _shouldNotifyMeta,
        shouldNotify.isAcceptableOrUnknown(
          data['should_notify']!,
          _shouldNotifyMeta,
        ),
      );
    }
    if (data.containsKey('notification_sent')) {
      context.handle(
        _notificationSentMeta,
        notificationSent.isAcceptableOrUnknown(
          data['notification_sent']!,
          _notificationSentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      dateAndTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_and_time'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      shouldNotify: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}should_notify'],
      )!,
      notificationSent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_sent'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String description;
  final DateTime dateAndTime;
  final String type;
  final bool shouldNotify;
  final bool notificationSent;
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dateAndTime,
    required this.type,
    required this.shouldNotify,
    required this.notificationSent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['date_and_time'] = Variable<DateTime>(dateAndTime);
    map['type'] = Variable<String>(type);
    map['should_notify'] = Variable<bool>(shouldNotify);
    map['notification_sent'] = Variable<bool>(notificationSent);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      dateAndTime: Value(dateAndTime),
      type: Value(type),
      shouldNotify: Value(shouldNotify),
      notificationSent: Value(notificationSent),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      dateAndTime: serializer.fromJson<DateTime>(json['dateAndTime']),
      type: serializer.fromJson<String>(json['type']),
      shouldNotify: serializer.fromJson<bool>(json['shouldNotify']),
      notificationSent: serializer.fromJson<bool>(json['notificationSent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'dateAndTime': serializer.toJson<DateTime>(dateAndTime),
      'type': serializer.toJson<String>(type),
      'shouldNotify': serializer.toJson<bool>(shouldNotify),
      'notificationSent': serializer.toJson<bool>(notificationSent),
    };
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dateAndTime,
    String? type,
    bool? shouldNotify,
    bool? notificationSent,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    dateAndTime: dateAndTime ?? this.dateAndTime,
    type: type ?? this.type,
    shouldNotify: shouldNotify ?? this.shouldNotify,
    notificationSent: notificationSent ?? this.notificationSent,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      dateAndTime: data.dateAndTime.present
          ? data.dateAndTime.value
          : this.dateAndTime,
      type: data.type.present ? data.type.value : this.type,
      shouldNotify: data.shouldNotify.present
          ? data.shouldNotify.value
          : this.shouldNotify,
      notificationSent: data.notificationSent.present
          ? data.notificationSent.value
          : this.notificationSent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('type: $type, ')
          ..write('shouldNotify: $shouldNotify, ')
          ..write('notificationSent: $notificationSent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    dateAndTime,
    type,
    shouldNotify,
    notificationSent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.dateAndTime == this.dateAndTime &&
          other.type == this.type &&
          other.shouldNotify == this.shouldNotify &&
          other.notificationSent == this.notificationSent);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> dateAndTime;
  final Value<String> type;
  final Value<bool> shouldNotify;
  final Value<bool> notificationSent;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dateAndTime = const Value.absent(),
    this.type = const Value.absent(),
    this.shouldNotify = const Value.absent(),
    this.notificationSent = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required DateTime dateAndTime,
    required String type,
    this.shouldNotify = const Value.absent(),
    this.notificationSent = const Value.absent(),
  }) : title = Value(title),
       description = Value(description),
       dateAndTime = Value(dateAndTime),
       type = Value(type);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? dateAndTime,
    Expression<String>? type,
    Expression<bool>? shouldNotify,
    Expression<bool>? notificationSent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dateAndTime != null) 'date_and_time': dateAndTime,
      if (type != null) 'type': type,
      if (shouldNotify != null) 'should_notify': shouldNotify,
      if (notificationSent != null) 'notification_sent': notificationSent,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime>? dateAndTime,
    Value<String>? type,
    Value<bool>? shouldNotify,
    Value<bool>? notificationSent,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      type: type ?? this.type,
      shouldNotify: shouldNotify ?? this.shouldNotify,
      notificationSent: notificationSent ?? this.notificationSent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dateAndTime.present) {
      map['date_and_time'] = Variable<DateTime>(dateAndTime.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (shouldNotify.present) {
      map['should_notify'] = Variable<bool>(shouldNotify.value);
    }
    if (notificationSent.present) {
      map['notification_sent'] = Variable<bool>(notificationSent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('type: $type, ')
          ..write('shouldNotify: $shouldNotify, ')
          ..write('notificationSent: $notificationSent')
          ..write(')'))
        .toString();
  }
}

class TasksViewData extends DataClass {
  final String title;
  const TasksViewData({required this.title});
  factory TasksViewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TasksViewData(title: serializer.fromJson<String>(json['title']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'title': serializer.toJson<String>(title)};
  }

  TasksViewData copyWith({String? title}) =>
      TasksViewData(title: title ?? this.title);
  @override
  String toString() {
    return (StringBuffer('TasksViewData(')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => title.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasksViewData && other.title == this.title);
}

class $TasksViewView extends ViewInfo<$TasksViewView, TasksViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$Database attachedDatabase;
  $TasksViewView(this.attachedDatabase, [this._alias]);
  $TasksTable get tasks => attachedDatabase.tasks.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [title];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'tasks_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $TasksViewView get asDslTable => this;
  @override
  TasksViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TasksViewData(
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
    );
  }

  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    generatedAs: GeneratedAs(tasks.title, false),
    type: DriftSqlType.string,
  );
  @override
  $TasksViewView createAlias(String alias) {
    return $TasksViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(tasks)..addColumns($columns));
  @override
  Set<String> get readTables => const {'tasks'};
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TasksViewView tasksView = $TasksViewView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, tasksView];
}

typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      required String title,
      required String description,
      required DateTime dateAndTime,
      required String type,
      Value<bool> shouldNotify,
      Value<bool> notificationSent,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<DateTime> dateAndTime,
      Value<String> type,
      Value<bool> shouldNotify,
      Value<bool> notificationSent,
    });

class $$TasksTableFilterComposer extends Composer<_$Database, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateAndTime => $composableBuilder(
    column: $table.dateAndTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get shouldNotify => $composableBuilder(
    column: $table.shouldNotify,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationSent => $composableBuilder(
    column: $table.notificationSent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer extends Composer<_$Database, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateAndTime => $composableBuilder(
    column: $table.dateAndTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get shouldNotify => $composableBuilder(
    column: $table.shouldNotify,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationSent => $composableBuilder(
    column: $table.notificationSent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer extends Composer<_$Database, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateAndTime => $composableBuilder(
    column: $table.dateAndTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get shouldNotify => $composableBuilder(
    column: $table.shouldNotify,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationSent => $composableBuilder(
    column: $table.notificationSent,
    builder: (column) => column,
  );
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$Database,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$Database, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$Database db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> dateAndTime = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> shouldNotify = const Value.absent(),
                Value<bool> notificationSent = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                description: description,
                dateAndTime: dateAndTime,
                type: type,
                shouldNotify: shouldNotify,
                notificationSent: notificationSent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String description,
                required DateTime dateAndTime,
                required String type,
                Value<bool> shouldNotify = const Value.absent(),
                Value<bool> notificationSent = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                dateAndTime: dateAndTime,
                type: type,
                shouldNotify: shouldNotify,
                notificationSent: notificationSent,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$Database, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
}
