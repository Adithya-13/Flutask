part of 'task_category_bloc.dart';

abstract class TaskCategoryEvent extends Equatable {
  const TaskCategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetTaskCategory extends TaskCategoryEvent {}

class WatchTaskCategory extends TaskCategoryEvent {}

class InsertTaskCategory extends TaskCategoryEvent {
  final TaskCategoryItemEntity taskCategoryItemEntity;

  InsertTaskCategory({required this.taskCategoryItemEntity});

  @override
  List<Object?> get props => [taskCategoryItemEntity];
}

class UpdateTaskCategory extends TaskCategoryEvent {
  final TaskCategoryItemEntity taskCategoryItemEntity;

  UpdateTaskCategory({required this.taskCategoryItemEntity});

  @override
  List<Object?> get props => [taskCategoryItemEntity];
}

class DeleteTaskCategory extends TaskCategoryEvent {
  final int id;

  DeleteTaskCategory({required this.id});

  @override
  List<Object?> get props => [id];
}
