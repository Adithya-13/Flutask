import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get categoryId => integer()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  DateTimeColumn get deadline => dateTime().nullable()();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}

@DataClassName('TaskCategory')
class TaskCategories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  IntColumn get startColor => integer()();

  IntColumn get endColor => integer()();
}

@UseMoor(tables: [Tasks, TaskCategories])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from <= 3) {
          await m.addColumn(tasks, tasks.isCompleted);
        }
      }
  );
}
