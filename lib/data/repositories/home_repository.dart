import 'package:flutask/data/data_providers/local/dummy_data.dart';
import 'package:flutask/data/entities/entities.dart';

class HomeRepository {
  Future<TaskCategoryEntity> getTaskCategoryEntity() async {
    final TaskCategoryEntity entity = DummyData.getTaskCategoryEntity();
    return entity;
  }
}