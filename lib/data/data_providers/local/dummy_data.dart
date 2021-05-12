import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/presentation/utils/utils.dart';

class DummyData {
  static TaskCategoryEntity getTaskCategoryEntity() =>
      TaskCategoryEntity(taskCategoryList: [
        TaskCategoryItemEntity(
          id: 0,
          title: "Mobile App Design",
          totalTask: 10,
          gradient: AppTheme.pinkGradient,
        ),
        TaskCategoryItemEntity(
          id: 1,
          title: "Pending",
          totalTask: 26,
          gradient: AppTheme.orangeGradient,
        ),
        TaskCategoryItemEntity(
          id: 2,
          title: "Illustration",
          totalTask: 6,
          gradient: AppTheme.blueGradient,
        ),
        TaskCategoryItemEntity(
          id: 3,
          title: "Website Design",
          totalTask: 10,
          gradient: AppTheme.purpleGradient,
        ),
      ]);
}
