import 'package:flutask/data/entities/entities.dart';
import 'package:flutter/material.dart';

class TaskEntity extends BaseEntity {
  final List<TaskItemEntity> tasksList;

  TaskEntity({required this.tasksList});
}

class TaskItemEntity extends BaseEntity {
  final int id;
  final String title;
  final int totalTask;
  final LinearGradient gradient;

  TaskItemEntity(
      {required this.id,
      required this.title,
      required this.totalTask,
      required this.gradient});
}
