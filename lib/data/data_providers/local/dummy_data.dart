import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/presentation/utils/utils.dart';

class DummyData {
  static TaskCategoryEntity getTaskCategoryEntity() =>
      TaskCategoryEntity(taskCategoryList: [
        TaskCategoryItemEntity(
          id: 0,
          title: "Mobile App Design",
          gradient: AppTheme.pinkGradient,
        ),
        TaskCategoryItemEntity(
          id: 1,
          title: "Pending",
          gradient: AppTheme.orangeGradient,
        ),
        TaskCategoryItemEntity(
          id: 2,
          title: "Illustration",
          gradient: AppTheme.blueGradient,
        ),
        TaskCategoryItemEntity(
          id: 3,
          title: "Website Design",
          gradient: AppTheme.purpleGradient,
        ),
      ]);
}
