import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/repositories/repositories.dart';

part 'task_category_event.dart';

part 'task_category_state.dart';

class TaskCategoryBloc extends Bloc<TaskCategoryEvent, TaskCategoryState> {
  final TaskRepository _taskRepository;

  TaskCategoryBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskCategoryInitial());

  @override
  Stream<TaskCategoryState> mapEventToState(
    TaskCategoryEvent event,
  ) async* {
    if (event is GetTaskCategory) {
      yield* _mapTaskCategoryFetchedToState(event);
    } else if (event is WatchTaskCategory) {
      yield* _mapWatchTaskCategoryToState(event);
    } else if (event is InsertTaskCategory) {
      yield* _mapInsertTaskCategoryToState(event);
    } else if (event is UpdateTaskCategory) {
      yield* _mapUpdateTaskCategoryToState(event);
    } else if (event is DeleteTaskCategory) {
      yield* _mapDeleteTaskCategoryToState(event);
    }
  }

  Stream<TaskCategoryState> _mapTaskCategoryFetchedToState(
      GetTaskCategory event) async* {
    yield TaskCategoryLoading();
    try {
      final TaskCategoryEntity entity =
          await _taskRepository.getAllTaskCategories();
      yield TaskCategorySuccess(entity: entity);
    } catch (e) {
      yield TaskCategoryFailure(message: e.toString());
    }
  }

  Stream<TaskCategoryState> _mapWatchTaskCategoryToState(
      WatchTaskCategory event) async* {
    final Stream<CategoryTotalTaskEntity> entity =
        _taskRepository.watchAllTaskCategories();
    yield TaskCategoryStream(entity: entity);
  }

  Stream<TaskCategoryState> _mapInsertTaskCategoryToState(
      InsertTaskCategory event) async* {
    _taskRepository.insertNewCategory(event.taskCategoryItemEntity);
  }

  Stream<TaskCategoryState> _mapUpdateTaskCategoryToState(
      UpdateTaskCategory event) async* {
    _taskRepository.updateCategory(event.taskCategoryItemEntity);
  }

  Stream<TaskCategoryState> _mapDeleteTaskCategoryToState(
      DeleteTaskCategory event) async* {
    _taskRepository.deleteCategory(event.id);
  }
}
