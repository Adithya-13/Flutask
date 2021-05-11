part of 'task_category_bloc.dart';

abstract class TaskCategoryEvent extends Equatable {
  const TaskCategoryEvent();

  @override
  List<Object?> get props => [];
}

class TaskCategoryFetched extends TaskCategoryEvent {}

