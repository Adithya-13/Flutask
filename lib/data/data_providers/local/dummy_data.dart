import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/presentation/utils/utils.dart';

class DummyData {
  static TaskEntity getTaskEntity() => TaskEntity(tasksList: [
    TaskItemEntity(id: 0, title: "Mobile App Design", totalTask: 10, gradient: AppTheme.pinkGradient),
    TaskItemEntity(id: 1, title: "Pending", totalTask: 26, gradient: AppTheme.orangeGradient),
    TaskItemEntity(id: 2, title: "Illustration", totalTask: 6, gradient: AppTheme.blueGradient),
    TaskItemEntity(id: 3, title: "Website Design", totalTask: 10, gradient: AppTheme.purpleGradient),
  ]);
}