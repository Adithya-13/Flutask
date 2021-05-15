import 'package:flutask/data/entities/entities.dart';

class TaskWithCategoryEntity extends BaseEntity {
  final List<TaskWithCategoryItemEntity> taskWithCategoryList;

  TaskWithCategoryEntity({required this.taskWithCategoryList});
}

class TaskWithCategoryItemEntity extends BaseEntity {
  final TaskItemEntity taskItemEntity;
  final TaskCategoryItemEntity taskCategoryItemEntity;

  TaskWithCategoryItemEntity({
    required this.taskItemEntity,
    required this.taskCategoryItemEntity,
  });
}
