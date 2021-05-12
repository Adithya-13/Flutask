import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get categoryId => integer()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  DateTimeColumn get deadline => dateTime()();
}

@DataClassName('TaskCategory')
class TaskCategories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  IntColumn get totalTasks => integer().withDefault(const Constant(0))();

  IntColumn get startColor => integer()();

  IntColumn get endColor => integer()();
}

@UseMoor(tables: [Tasks, TaskCategories])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  int get schemaVersion => 1;
}
