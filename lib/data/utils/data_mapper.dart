import 'package:flutask/data/data_providers/local/moor_database.dart';
import 'package:flutask/data/entities/entities.dart';

class DataMapper {
  static TaskEntity toTaskEntity(List<Task> tasks) => TaskEntity(
          tasksList: tasks.map((item) {
        return TaskItemEntity(
            id: item.id,
            categoryId: item.categoryId,
            title: item.title,
            description: item.description,
            deadline: item.deadline);
      }).toList());

  static TasksCompanion toTask(TaskItemEntity item) => TasksCompanion.insert(
        categoryId: item.categoryId,
        title: item.title,
        description: item.description,
        deadline: item.deadline,
      );
}
