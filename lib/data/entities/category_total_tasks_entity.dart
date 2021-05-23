import 'package:flutask/data/entities/entities.dart';

class CategoryTotalTaskEntity extends BaseEntity {
  final List<CategoryTotalTaskItemEntity> categoryTotalTaskList;

  CategoryTotalTaskEntity({required this.categoryTotalTaskList});
}

class CategoryTotalTaskItemEntity extends BaseEntity {
  final TaskCategoryItemEntity taskCategoryItemEntity;
  final int totalTasks;
  final int completeTasks;

  CategoryTotalTaskItemEntity({
    required this.taskCategoryItemEntity,
    required this.totalTasks,
    required this.completeTasks,
  });
}
