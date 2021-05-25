part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class GetTask extends TaskEvent {}

class WatchTask extends TaskEvent {}

class WatchTaskByStatus extends TaskEvent {
  final StatusType statusType;

  WatchTaskByStatus({required this.statusType});

  @override
  List<Object?> get props => [statusType];
}

class WatchTaskByDate extends TaskEvent {
  final DateTime dateTime;

  WatchTaskByDate({required this.dateTime});

  @override
  List<Object?> get props => [dateTime];
}

class WatchOnGoingTask extends TaskEvent {}

class WatchCompletedTask extends TaskEvent {}

class WatchTaskByCategory extends TaskEvent {
  final int id;

  WatchTaskByCategory({required this.id});

  @override
  List<Object?> get props => [id];
}

class InsertTask extends TaskEvent {
  final TaskItemEntity taskItemEntity;

  InsertTask({required this.taskItemEntity});

  @override
  List<Object?> get props => [taskItemEntity];
}

class UpdateTask extends TaskEvent {
  final TaskItemEntity taskItemEntity;

  UpdateTask({required this.taskItemEntity});

  @override
  List<Object?> get props => [taskItemEntity];
}

class DeleteTask extends TaskEvent {
  final int id;

  DeleteTask({required this.id});

  @override
  List<Object?> get props => [id];
}
