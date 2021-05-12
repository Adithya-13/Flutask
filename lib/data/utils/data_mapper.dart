import 'package:flutask/data/data_providers/local/moor_database.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';

class DataMapper {
  static TaskEntity toTaskEntity(List<Task> tasks) => TaskEntity(
      tasksList: tasks
          .map((item) => TaskItemEntity(
              id: item.id,
              categoryId: item.categoryId,
              title: item.title,
              description: item.description,
              deadline: item.deadline))
          .toList());

  static TasksCompanion toTask(TaskItemEntity item) => TasksCompanion.insert(
        categoryId: item.categoryId,
        title: item.title,
        description: item.description,
        deadline: item.deadline,
      );

  static TaskCategoryEntity toTaskCategoryEntity(
          List<TaskCategory> categories) =>
      TaskCategoryEntity(
        taskCategoryList: categories
            .map(
              (item) => TaskCategoryItemEntity(
                id: item.id,
                title: item.title,
                totalTask: item.totalTasks,
                gradient: LinearGradient(
                  colors: [
                    Color(item.startColor),
                    Color(item.endColor),
                  ],
                ),
              ),
            )
            .toList(),
      );

  static TaskCategoriesCompanion toCategory(TaskCategoryItemEntity item) =>
      TaskCategoriesCompanion.insert(
        title: item.title,
        startColor: item.gradient.colors[0].value,
        endColor: item.gradient.colors[1].value,
        totalTasks: Value(item.totalTask),
      );
}
