import 'package:flutask/data/data_providers/local/task_dao.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/entities/task_with_category_entity.dart';
import 'package:flutask/data/utils/data_mapper.dart';

class TaskRepository {
  final TaskDao _taskDao;

  TaskRepository({required TaskDao taskDao}) : _taskDao = taskDao;

  Future<TaskEntity> getAllTasks() async =>
      _taskDao.getAllTasks().then((value) => DataMapper.toTaskEntity(value));

  Stream<TaskEntity> watchAllTasks() =>
      _taskDao.watchAllTasks().map((event) => DataMapper.toTaskEntity(event));

  Stream<TaskWithCategoryEntity> watchAllTaskWithCategory() =>
      _taskDao.watchAllTaskWithCategory().map((event) => DataMapper.toTaskWithCategoryEntity(event));

  Stream<TaskEntity> watchOnGoingTasks() =>
      _taskDao.watchOnGoingTask().map((event) => DataMapper.toTaskEntity(event));

  Stream<TaskEntity> watchCompletedTasks() =>
      _taskDao.watchCompletedTask().map((event) => DataMapper.toTaskEntity(event));

  Future<int> insertNewTask(TaskItemEntity item) {
    return _taskDao.insertNewTask(DataMapper.toTask(item));
  }

  Future<bool> updateTask(TaskItemEntity item) =>
      _taskDao.updateTask(DataMapper.toUpdatedTask(item));

  Future<int> deleteTask(int id) => _taskDao.deleteTask(id);

  Future<TaskCategoryEntity> getAllTaskCategories() async => _taskDao
      .getAllTaskCategories()
      .then((item) => DataMapper.toTaskCategoryEntity(item));

  Stream<TaskCategoryEntity> watchAllTaskCategories() => _taskDao
      .watchAllTaskCategories()
      .map((event) => DataMapper.toTaskCategoryEntity(event));

  Stream<TaskEntity> watchAllTaskByCategory(int categoryId) => _taskDao
      .watchAllTaskByCategory(categoryId)
      .map((event) => DataMapper.toTaskEntity(event));

  Future<int> insertNewCategory(TaskCategoryItemEntity newCategory) =>
      _taskDao.insertNewCategory(DataMapper.toCategory(newCategory));

  Future<bool> updateCategory(TaskCategoryItemEntity updateCategory) =>
      _taskDao.updateCategory(DataMapper.toCategory(updateCategory));

  Future<int> deleteCategory(int id) => _taskDao.deleteCategory(id);
}
