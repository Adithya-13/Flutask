import 'package:flutask/data/entities/entities.dart';

class TaskEntity extends BaseEntity {
  final List<TaskItemEntity> tasksList;

  TaskEntity({required this.tasksList});
}

class TaskItemEntity extends BaseEntity {
  final int? id;
  final int categoryId;
  final String title;
  final String description;
  final DateTime? deadline;

  TaskItemEntity(
      {this.id,
      required this.categoryId,
      required this.title,
      required this.description,
      this.deadline});
}
