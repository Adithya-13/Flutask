import 'package:moor_flutter/moor_flutter.dart';

import 'moor_database.dart';

part 'task_dao.g.dart';

@UseDao(tables: [Tasks, TaskCategories])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(AppDatabase db) : super(db);

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future<int> insertNewTask(TasksCompanion newTask) =>
      into(tasks).insert(newTask);

  Future<bool> updateTask(TasksCompanion updateTask) =>
      update(tasks).replace(updateTask);

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();

  Future<List<TaskCategory>> getAllTaskCategories() =>
      select(taskCategories).get();

  Stream<List<TaskCategory>> watchAllTaskCategories() =>
      select(taskCategories).watch();

  Stream<List<Task>> getAllTaskByCategory(int categoryId) =>
      (select(tasks)..where((tbl) => tbl.categoryId.equals(categoryId)))
          .watch();

  Future<int> insertNewCategory(TaskCategoriesCompanion newCategory) =>
      into(taskCategories).insert(newCategory);

  Future<bool> updateCategory(TaskCategoriesCompanion updateCategory) =>
      update(taskCategories).replace(updateCategory);

  Future<int> deleteCategory(int id) =>
      (delete(taskCategories)..where((t) => t.id.equals(id))).go();
}
