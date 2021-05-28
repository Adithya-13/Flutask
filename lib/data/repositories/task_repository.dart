import 'package:flutask/data/data_providers/local/task_dao.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/utils/data_mapper.dart';
import 'package:flutask/presentation/utils/utils.dart';

class TaskRepository {
  final TaskDao _taskDao;

  TaskRepository({required TaskDao taskDao}) : _taskDao = taskDao;

  Future<TaskEntity> getAllTasks() async =>
      _taskDao.getAllTasks().then((value) => DataMapper.toTaskEntity(value));

  Stream<TaskWithCategoryEntity> watchAllTasks() => _taskDao
      .watchAllTasks()
      .map((event) => DataMapper.toTaskWithCategoryEntity(event));

  Stream<TaskWithCategoryEntity> watchOnGoingTasks() => _taskDao
      .watchOnGoingTask()
      .map((event) => DataMapper.toTaskWithCategoryEntity(event));

  Stream<TaskWithCategoryEntity> watchCompletedTasks() => _taskDao
      .watchCompletedTask()
      .map((event) => DataMapper.toTaskWithCategoryEntity(event));

  Stream<TaskWithCategoryEntity> watchAllTaskByCategory(int categoryId) =>
      _taskDao
          .watchAllTaskByCategory(categoryId)
          .map((event) => DataMapper.toTaskWithCategoryEntity(event));

  Stream<TaskWithCategoryEntity> watchAllTaskByStatus(StatusType statusType) =>
      _taskDao
          .watchAllTaskByStatus(statusType)
          .map((event) => DataMapper.toTaskWithCategoryEntity(event));

  Stream<TaskWithCategoryEntity> watchAllTaskByDate(DateTime dateTime) =>
      _taskDao
          .watchAllTaskByDate(dateTime)
          .map((event) => DataMapper.toTaskWithCategoryEntity(event));

  Stream<TaskWithCategoryEntity> searchTasks(String searchQuery) =>
      _taskDao
          .searchTasks(searchQuery)
          .map((event) => DataMapper.toTaskWithCategoryEntity(event));

  Future<int> insertNewTask(TaskItemEntity item) {
    return _taskDao.insertNewTask(DataMapper.toTask(item));
  }

  Future<bool> updateTask(TaskItemEntity item) =>
      _taskDao.updateTask(DataMapper.toUpdatedTask(item));

  Future<int> deleteTask(int id) => _taskDao.deleteTask(id);

  Future<TaskCategoryEntity> getAllTaskCategories() async => _taskDao
      .getAllTaskCategories()
      .then((item) => DataMapper.toTaskCategoryEntity(item));

  Stream<CategoryTotalTaskEntity> watchAllTaskCategories() => _taskDao
      .watchAllTaskCategories()
      .map((event) => DataMapper.toCategoryTotalTaskEntity(event));

  Future<int> insertNewCategory(TaskCategoryItemEntity newCategory) =>
      _taskDao.insertNewCategory(DataMapper.toCategory(newCategory));

  Future<bool> updateCategory(TaskCategoryItemEntity updateCategory) =>
      _taskDao.updateCategory(DataMapper.toCategory(updateCategory));

  Future<int> deleteCategory(int id) => _taskDao.deleteCategory(id);
}
