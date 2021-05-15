import 'package:flutask/data/models/models.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'moor_database.dart';

part 'task_dao.g.dart';

@UseDao(tables: [Tasks, TaskCategories])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(AppDatabase db) : super(db);

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() =>
      (select(tasks)..orderBy(orderTaskByDate())).watch();

  Stream<List<TaskWithCategory>> watchAllTaskWithCategory() {
    final query = select(tasks).join([
      leftOuterJoin(
          taskCategories, taskCategories.id.equalsExp(tasks.categoryId))
    ]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return TaskWithCategory(
          row.readTable(tasks),
          row.readTableOrNull(taskCategories)!,
        );
      }).toList();
    });
  }

  Stream<List<Task>> watchAllTaskByCategory(int categoryId) => (select(tasks)
        ..where((tbl) => tbl.categoryId.equals(categoryId))
        ..orderBy(orderTaskByDate()))
      .watch();

  Stream<List<Task>> watchOnGoingTask() => (select(tasks)
        ..where((tbl) => tbl.isCompleted.equals(false))
        ..orderBy(orderTaskByDate()))
      .watch();

  Stream<List<Task>> watchCompletedTask() => (select(tasks)
        ..where((tbl) => tbl.isCompleted.equals(true))
        ..orderBy(orderTaskByDate()))
      .watch();

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

    final query = db.select(taskCategories).join([
      leftOuterJoin(tasks, tasks.categoryId.equalsExp(taskCategories.id),
          useColumns: false)
    ]);

    query
      ..addColumns([amountOfTasks])
      ..groupBy([taskCategories.id]);

    return query.watch().map((event) {
      return event
          .map((row) => CategoryTotalTask(
              row.readTable(taskCategories), row.read(amountOfTasks)))
          .toList();
    });
  }

  Future<int> insertNewCategory(TaskCategoriesCompanion newCategory) =>
      into(taskCategories).insert(newCategory);

  Future<bool> updateCategory(TaskCategoriesCompanion updateCategory) =>
      update(taskCategories).replace(updateCategory);

  Future<int> deleteCategory(int id) =>
      (delete(taskCategories)..where((t) => t.id.equals(id))).go();

  List<OrderingTerm Function($TasksTable)> orderTaskByDate() => [
        (t) => OrderingTerm(
            expression: t.deadline.isNotNull(), mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.deadline, mode: OrderingMode.asc),
      ];
}
