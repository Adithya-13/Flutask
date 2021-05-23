import 'package:flutask/data/models/models.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'moor_database.dart';

part 'task_dao.g.dart';

@UseDao(tables: [Tasks, TaskCategories])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(AppDatabase db) : super(db);

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<TaskWithCategory>> watchAllTasks() {
    final query = (select(tasks)..orderBy(orderTaskByDate()))
        .join(leftOuterJoinTaskWithCategory());

    return toTaskWithCategory(query);
  }

  Stream<List<TaskWithCategory>> watchAllTaskByCategory(int categoryId) {
    final query = (select(tasks)
          ..where((tbl) => tbl.categoryId.equals(categoryId))
          ..orderBy(orderTaskByDate()))
        .join(leftOuterJoinTaskWithCategory());

    return toTaskWithCategory(query);
  }

  Stream<List<TaskWithCategory>> watchAllTaskByStatus(StatusType statusType) {
    final status = statusType == StatusType.ON_GOING ? false : true;
    final query = (select(tasks)
      ..where((tbl) => tbl.isCompleted.equals(status))
      ..orderBy(orderTaskByDate()))
        .join(leftOuterJoinTaskWithCategory());

    return toTaskWithCategory(query);
  }

  Stream<List<TaskWithCategory>> watchOnGoingTask() {
    final query = (select(tasks)
          ..where((tbl) => tbl.isCompleted.equals(false))
          ..orderBy(orderTaskByDate()))
        .join(leftOuterJoinTaskWithCategory());

    return toTaskWithCategory(query);
  }

  Stream<List<TaskWithCategory>> watchCompletedTask() {
    final query = (select(tasks)
          ..where((tbl) => tbl.isCompleted.equals(true))
          ..orderBy(orderTaskByDate()))
        .join(leftOuterJoinTaskWithCategory());

    return toTaskWithCategory(query);
  }

  Future<int> insertNewTask(TasksCompanion newTask) =>
      into(tasks).insert(newTask);

  Future<bool> updateTask(TasksCompanion updateTask) =>
      update(tasks).replace(updateTask);

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();

  Future<List<TaskCategory>> getAllTaskCategories() =>
      select(taskCategories).get();

  Stream<List<CategoryTotalTask>> watchAllTaskCategories() {
    final amountOfTasks = tasks.id.count();
    final completeTasks = tasks.isCompleted.equals(true);

    final query =
        db.select(taskCategories).join(leftOuterJoinCategoryTotalTask());

    query
      ..addColumns([amountOfTasks])
      ..addColumns([completeTasks.count()])
      ..groupBy([taskCategories.id]);

    return toCategoryTotalTask(query, amountOfTasks, completeTasks.count());
  }

  Future<int> insertNewCategory(TaskCategoriesCompanion newCategory) =>
      into(taskCategories).insert(newCategory);

  Future<bool> updateCategory(TaskCategoriesCompanion updateCategory) =>
      update(taskCategories).replace(updateCategory);

  Future<int> deleteCategory(int id) =>
      (delete(taskCategories)..where((t) => t.id.equals(id))).go();

  //////////////////// FUNCTION HELPER /////////////////////////

  List<OrderingTerm Function($TasksTable)> orderTaskByDate() {
    return [
      (t) => OrderingTerm(
          expression: t.deadline.isNotNull(), mode: OrderingMode.desc),
      (t) => OrderingTerm(expression: t.deadline, mode: OrderingMode.asc),
    ];
  }

  List<Join> leftOuterJoinTaskWithCategory() => [
        leftOuterJoin(
            taskCategories, taskCategories.id.equalsExp(tasks.categoryId))
      ];

  List<Join> leftOuterJoinCategoryTotalTask() => [
        leftOuterJoin(tasks, tasks.categoryId.equalsExp(taskCategories.id),
            useColumns: false)
      ];

  Stream<List<TaskWithCategory>> toTaskWithCategory(
      JoinedSelectStatement<Table, DataClass> query) {
    return query.watch().map((rows) {
      return rows.map((row) {
        return TaskWithCategory(
          row.readTable(tasks),
          row.readTableOrNull(taskCategories)!,
        );
      }).toList();
    });
  }

  Stream<List<CategoryTotalTask>> toCategoryTotalTask(
    JoinedSelectStatement<Table, DataClass> query,
    Expression<int> amountOfTasks,
    Expression<int> completeTasks,
  ) {
    return query.watch().map((event) {
      return event.map(
        (row) {
          print(
              "amountOfTasks ${row.read(amountOfTasks)}, completeTasks ${row.read(completeTasks)}");
          return CategoryTotalTask(
            row.readTable(taskCategories),
            row.read(amountOfTasks),
            row.read(completeTasks),
          );
        },
      ).toList();
    });
  }
}
