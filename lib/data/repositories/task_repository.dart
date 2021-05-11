import 'package:flutask/data/data_providers/local/moor_database.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/utils/data_mapper.dart';

class TaskRepository {
  final AppDatabase _appDatabase;

  TaskRepository({required AppDatabase appDatabase}): _appDatabase = appDatabase;

  Future<TaskEntity> getAllTasks() async =>
      _appDatabase.getAllTasks().then((value) => DataMapper.toTaskEntity(value));

  Stream<TaskEntity> watchAllTasks() => _appDatabase
      .watchAllTasks()
      .map((event) => DataMapper.toTaskEntity(event));

  Future<int> insertNewTask(TaskItemEntity item) {
    print('blabla');
    return _appDatabase.insertNewTask(DataMapper.toTask(item));
  }

  Future<bool> updateTask(TaskItemEntity item) =>
      _appDatabase.updateTask(DataMapper.toTask(item));

  Future<int> deleteTask(int id) =>
      _appDatabase.deleteTask(id);
}
