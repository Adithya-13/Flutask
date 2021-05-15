part of 'task_category_bloc.dart';

abstract class TaskCategoryState extends Equatable {
  const TaskCategoryState();

  @override
  List<Object> get props => [];
}

class TaskCategoryInitial extends TaskCategoryState {}

class TaskCategoryLoading extends TaskCategoryState {}

class TaskCategorySuccess extends TaskCategoryState {
  final TaskCategoryEntity entity;

  TaskCategorySuccess({required this.entity});

  @override
  List<Object> get props => [entity];
}

class TaskCategoryStream extends TaskCategoryState {
  final Stream<CategoryTotalTaskEntity> entity;

  TaskCategoryStream({required this.entity});

  @override
  List<Object> get props => [entity];
}

class TaskCategoryFailure extends TaskCategoryState {
  final String message;

  TaskCategoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}
