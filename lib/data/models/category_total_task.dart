import 'package:flutask/data/data_providers/local/moor_database.dart';

class CategoryTotalTask {
  final TaskCategory category;
  final int totalTasks;
  final int completeTasks;

  CategoryTotalTask(this.category,this.totalTasks, this.completeTasks);
}
