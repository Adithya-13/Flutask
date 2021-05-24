import 'package:flutask/data/data_providers/local/moor_database.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/models/models.dart';
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
              deadline: item.deadline,
              isCompleted: item.isCompleted))
          .toList());

  static TaskItemEntity toTaskItemEntity(Task task) => TaskItemEntity(
      id: task.id,
      categoryId: task.categoryId,
      title: task.title,
      description: task.description,
      deadline: task.deadline,
      isCompleted: task.isCompleted);

  static TaskWithCategoryEntity toTaskWithCategoryEntity(
          List<TaskWithCategory> taskWithCategory) =>
      TaskWithCategoryEntity(
          taskWithCategoryList: taskWithCategory
              .map((item) => TaskWithCategoryItemEntity(
                  taskItemEntity: toTaskItemEntity(item.task),
                  taskCategoryItemEntity:
                      toTaskCategoryItemEntity(item.taskCategory)))
              .toList());

  static CategoryTotalTaskEntity toCategoryTotalTaskEntity(
          List<CategoryTotalTask> categoryTotalTasks) =>
      CategoryTotalTaskEntity(
          categoryTotalTaskList: categoryTotalTasks
              .map((item) => CategoryTotalTaskItemEntity(
                    taskCategoryItemEntity:
                        toTaskCategoryItemEntity(item.category),
                    totalTasks: item.totalTasks,
                  ))
              .toList());

  static TasksCompanion toTask(TaskItemEntity item) => TasksCompanion.insert(
        categoryId: item.categoryId,
        title: item.title,
        description: item.description,
        deadline: Value(item.deadline),
        isCompleted: item.isCompleted,
      );

  static TasksCompanion toUpdatedTask(TaskItemEntity item) =>
      TasksCompanion.insert(
        id: Value(item.id!),
        categoryId: item.categoryId,
        title: item.title,
        description: item.description,
        deadline: Value(item.deadline),
        isCompleted: item.isCompleted,
      );

  static TaskCategoryEntity toTaskCategoryEntity(
          List<TaskCategory> categories) =>
      TaskCategoryEntity(
        taskCategoryList: categories
            .map(
              (item) => TaskCategoryItemEntity(
                id: item.id,
                title: item.title,
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

  static TaskCategoryItemEntity toTaskCategoryItemEntity(
          TaskCategory category) =>
      TaskCategoryItemEntity(
        id: category.id,
        title: category.title,
        gradient: LinearGradient(
          colors: [
            Color(category.startColor),
            Color(category.endColor),
          ],
        ),
      );

  static TaskCategoriesCompanion toCategory(TaskCategoryItemEntity item) =>
      TaskCategoriesCompanion.insert(
        title: item.title,
        startColor: item.gradient.colors[0].value,
        endColor: item.gradient.colors[1].value,
      );
}
