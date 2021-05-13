import 'package:flutask/data/entities/entities.dart';
import 'package:flutter/material.dart';

class TaskCategoryEntity extends BaseEntity {
  final List<TaskCategoryItemEntity> taskCategoryList;

  TaskCategoryEntity({required this.taskCategoryList});
}

class TaskCategoryItemEntity extends BaseEntity {
  final int id;
  final String title;
  final LinearGradient gradient;

  TaskCategoryItemEntity(
      {required this.id,
      required this.title,
      required this.gradient});
}
