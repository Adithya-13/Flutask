import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/presentation/utils/utils.dart';

class DummyData {
  static TaskCategoryEntity getTaskCategoryEntity() =>
      TaskCategoryEntity(taskCategoryList: [
        TaskCategoryItemEntity(
            id: 0,
            title: "Mobile App Design",
            totalTask: 10,
            startColor: AppTheme.pinkGradient.colors[0].value,
            endColor: AppTheme.pinkGradient.colors[1].value),
        TaskCategoryItemEntity(
            id: 1,
            title: "Pending",
            totalTask: 26,
            startColor: AppTheme.orangeGradient.colors[0].value,
            endColor: AppTheme.orangeGradient.colors[1].value),
        TaskCategoryItemEntity(
            id: 2,
            title: "Illustration",
            totalTask: 6,
            startColor: AppTheme.blueGradient.colors[0].value,
            endColor: AppTheme.blueGradient.colors[1].value),
        TaskCategoryItemEntity(
            id: 3,
            title: "Website Design",
            totalTask: 10,
            startColor: AppTheme.purpleGradient.colors[0].value,
            endColor: AppTheme.purpleGradient.colors[1].value),
      ]);
}
