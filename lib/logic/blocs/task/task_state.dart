part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadData extends TaskState {}

class TaskSuccess extends TaskState {
  final TaskEntity entity;

  TaskSuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class TaskFailure extends TaskState {
  final String message;

  TaskFailure({required this.message});

  @override
  List<Object> get props => [message];
}
