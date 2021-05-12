// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final int categoryId;
  final String title;
  final String description;
  final DateTime deadline;
  Task(
      {required this.id,
      required this.categoryId,
      required this.title,
      required this.description,
      required this.deadline});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      categoryId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id'])!,
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      deadline: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deadline'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['deadline'] = Variable<DateTime>(deadline);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      title: Value(title),
      description: Value(description),
      deadline: Value(deadline),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'deadline': serializer.toJson<DateTime>(deadline),
    };
  }

  Task copyWith(
          {int? id,
          int? categoryId,
          String? title,
          String? description,
          DateTime? deadline}) =>
      Task(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        title: title ?? this.title,
        description: description ?? this.description,
        deadline: deadline ?? this.deadline,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('deadline: $deadline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          categoryId.hashCode,
          $mrjc(title.hashCode,
              $mrjc(description.hashCode, deadline.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.title == this.title &&
          other.description == this.description &&
          other.deadline == this.deadline);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> deadline;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.deadline = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String title,
    required String description,
    required DateTime deadline,
  })  : categoryId = Value(categoryId),
        title = Value(title),
        description = Value(description),
        deadline = Value(deadline);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? deadline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (deadline != null) 'deadline': deadline,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<int>? categoryId,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime>? deadline}) {
    return TasksCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('deadline: $deadline')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedIntColumn categoryId = _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn(
      'category_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedTextColumn description = _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deadlineMeta = const VerificationMeta('deadline');
  @override
  late final GeneratedDateTimeColumn deadline = _constructDeadline();
  GeneratedDateTimeColumn _constructDeadline() {
    return GeneratedDateTimeColumn(
      'deadline',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryId, title, description, deadline];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class TaskCategory extends DataClass implements Insertable<TaskCategory> {
  final int id;
  final String title;
  final int totalTasks;
  final int startColor;
  final int endColor;
  TaskCategory(
      {required this.id,
      required this.title,
      required this.totalTasks,
      required this.startColor,
      required this.endColor});
  factory TaskCategory.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return TaskCategory(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      totalTasks: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_tasks'])!,
      startColor: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}start_color'])!,
      endColor:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}end_color'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['total_tasks'] = Variable<int>(totalTasks);
    map['start_color'] = Variable<int>(startColor);
    map['end_color'] = Variable<int>(endColor);
    return map;
  }

  TaskCategoriesCompanion toCompanion(bool nullToAbsent) {
    return TaskCategoriesCompanion(
      id: Value(id),
      title: Value(title),
      totalTasks: Value(totalTasks),
      startColor: Value(startColor),
      endColor: Value(endColor),
    );
  }

  factory TaskCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TaskCategory(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      totalTasks: serializer.fromJson<int>(json['totalTasks']),
      startColor: serializer.fromJson<int>(json['startColor']),
      endColor: serializer.fromJson<int>(json['endColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'totalTasks': serializer.toJson<int>(totalTasks),
      'startColor': serializer.toJson<int>(startColor),
      'endColor': serializer.toJson<int>(endColor),
    };
  }

  TaskCategory copyWith(
          {int? id,
          String? title,
          int? totalTasks,
          int? startColor,
          int? endColor}) =>
      TaskCategory(
        id: id ?? this.id,
        title: title ?? this.title,
        totalTasks: totalTasks ?? this.totalTasks,
        startColor: startColor ?? this.startColor,
        endColor: endColor ?? this.endColor,
      );
  @override
  String toString() {
    return (StringBuffer('TaskCategory(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('totalTasks: $totalTasks, ')
          ..write('startColor: $startColor, ')
          ..write('endColor: $endColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(totalTasks.hashCode,
              $mrjc(startColor.hashCode, endColor.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TaskCategory &&
          other.id == this.id &&
          other.title == this.title &&
          other.totalTasks == this.totalTasks &&
          other.startColor == this.startColor &&
          other.endColor == this.endColor);
}

class TaskCategoriesCompanion extends UpdateCompanion<TaskCategory> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> totalTasks;
  final Value<int> startColor;
  final Value<int> endColor;
  const TaskCategoriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.totalTasks = const Value.absent(),
    this.startColor = const Value.absent(),
    this.endColor = const Value.absent(),
  });
  TaskCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.totalTasks = const Value.absent(),
    required int startColor,
    required int endColor,
  })  : title = Value(title),
        startColor = Value(startColor),
        endColor = Value(endColor);
  static Insertable<TaskCategory> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? totalTasks,
    Expression<int>? startColor,
    Expression<int>? endColor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (totalTasks != null) 'total_tasks': totalTasks,
      if (startColor != null) 'start_color': startColor,
      if (endColor != null) 'end_color': endColor,
    });
  }

  TaskCategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? totalTasks,
      Value<int>? startColor,
      Value<int>? endColor}) {
    return TaskCategoriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      totalTasks: totalTasks ?? this.totalTasks,
      startColor: startColor ?? this.startColor,
      endColor: endColor ?? this.endColor,
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
    if (totalTasks.present) {
      map['total_tasks'] = Variable<int>(totalTasks.value);
    }
    if (startColor.present) {
      map['start_color'] = Variable<int>(startColor.value);
    }
    if (endColor.present) {
      map['end_color'] = Variable<int>(endColor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('totalTasks: $totalTasks, ')
          ..write('startColor: $startColor, ')
          ..write('endColor: $endColor')
          ..write(')'))
        .toString();
  }
}

class $TaskCategoriesTable extends TaskCategories
    with TableInfo<$TaskCategoriesTable, TaskCategory> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TaskCategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalTasksMeta = const VerificationMeta('totalTasks');
  @override
  late final GeneratedIntColumn totalTasks = _constructTotalTasks();
  GeneratedIntColumn _constructTotalTasks() {
    return GeneratedIntColumn('total_tasks', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _startColorMeta = const VerificationMeta('startColor');
  @override
  late final GeneratedIntColumn startColor = _constructStartColor();
  GeneratedIntColumn _constructStartColor() {
    return GeneratedIntColumn(
      'start_color',
      $tableName,
      false,
    );
  }

  final VerificationMeta _endColorMeta = const VerificationMeta('endColor');
  @override
  late final GeneratedIntColumn endColor = _constructEndColor();
  GeneratedIntColumn _constructEndColor() {
    return GeneratedIntColumn(
      'end_color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, totalTasks, startColor, endColor];
  @override
  $TaskCategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'task_categories';
  @override
  final String actualTableName = 'task_categories';
  @override
  VerificationContext validateIntegrity(Insertable<TaskCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('total_tasks')) {
      context.handle(
          _totalTasksMeta,
          totalTasks.isAcceptableOrUnknown(
              data['total_tasks']!, _totalTasksMeta));
    }
    if (data.containsKey('start_color')) {
      context.handle(
          _startColorMeta,
          startColor.isAcceptableOrUnknown(
              data['start_color']!, _startColorMeta));
    } else if (isInserting) {
      context.missing(_startColorMeta);
    }
    if (data.containsKey('end_color')) {
      context.handle(_endColorMeta,
          endColor.isAcceptableOrUnknown(data['end_color']!, _endColorMeta));
    } else if (isInserting) {
      context.missing(_endColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TaskCategory.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TaskCategoriesTable createAlias(String alias) {
    return $TaskCategoriesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TaskCategoriesTable taskCategories = $TaskCategoriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, taskCategories];
}
