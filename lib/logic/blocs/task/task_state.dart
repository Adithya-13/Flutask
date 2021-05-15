part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final TaskEntity entity;

  TaskSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class TaskStream extends TaskState {
  final Stream<TaskWithCategoryEntity> entity;

  TaskStream({required this.entity});

  @override
  List<Object> get props => [entity];
}

class OnGoingTaskStream extends TaskState {
  final Stream<TaskWithCategoryEntity> entity;

  OnGoingTaskStream({required this.entity});

  @override
  List<Object> get props => [entity];
}

class CompletedTaskStream extends TaskState {
  final Stream<TaskWithCategoryEntity> entity;

  CompletedTaskStream({required this.entity});

  @override
  List<Object> get props => [entity];
}

class TaskByCategoryStream extends TaskState {
  final Stream<TaskWithCategoryEntity> entity;

  TaskByCategoryStream({required this.entity});

  @override
  List<Object> get props => [entity];
}

class TaskFailure extends TaskState {
  final String message;

  TaskFailure({required this.message});

  @override
  List<Object> get props => [message];
}
