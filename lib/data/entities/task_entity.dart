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
  final bool isCompleted;

  TaskItemEntity(
      {this.id,
      required this.categoryId,
      required this.title,
      required this.description,
      this.deadline,
      this.isCompleted = false});

  TaskItemEntity copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? description,
    DateTime? deadline,
    bool? isCompleted,
  }) {
    return TaskItemEntity(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        title: title ?? this.title,
        description: description ?? this.description,
        deadline: deadline ?? this.deadline,
        isCompleted: isCompleted ?? this.isCompleted);
  }
}
