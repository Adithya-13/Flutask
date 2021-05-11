import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get categoryId => integer()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  DateTimeColumn get deadline => dateTime()();
}

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future<int> insertNewTask(TasksCompanion newTask) => into(tasks).insert(newTask);

  Future<bool> updateTask(TasksCompanion updateTask) =>
      update(tasks).replace(updateTask);

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
