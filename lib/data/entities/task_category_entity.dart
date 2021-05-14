import 'package:flutask/data/entities/entities.dart';
import 'package:flutter/material.dart';

class TaskCategoryEntity extends BaseEntity {
  final List<TaskCategoryItemEntity> taskCategoryList;

  TaskCategoryEntity({required this.taskCategoryList});
}

class TaskCategoryItemEntity extends BaseEntity {
  final int? id;
  final String title;
  final LinearGradient gradient;

  TaskCategoryItemEntity(
      {this.id, required this.title, required this.gradient});

  TaskCategoryItemEntity copyWith({
    int? id,
    String? title,
    LinearGradient? gradient,
  }) {
    return TaskCategoryItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      gradient: gradient ?? this.gradient,
    );
  }
}
