import 'package:flutask/data/data_providers/local/dummy_data.dart';
import 'package:flutask/data/entities/entities.dart';

class HomeRepository {
  Future<TaskEntity> getTaskEntity() async {
    final TaskEntity entity = DummyData.getTaskEntity();
    return entity;
  }
}