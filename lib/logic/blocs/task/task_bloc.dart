import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/repositories/repositories.dart';
import 'package:flutask/presentation/utils/utils.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskInitial());

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is GetTask) {
      yield* _mapGetTaskToState(event);
    } else if (event is WatchTask) {
      yield* _mapWatchTaskToState(event);
    } else if (event is WatchOnGoingTask) {
      yield* _mapWatchOnGoingTaskToState(event);
    } else if (event is WatchCompletedTask) {
      yield* _mapWatchCompletedTaskToState(event);
    } else if (event is WatchTaskByCategory) {
      yield* _mapWatchTaskByCategoryToState(event);
    } else if (event is WatchTaskByStatus) {
      yield* _mapWatchTaskByStatusToState(event);
    } else if (event is WatchTaskByDate) {
      yield* _mapWatchTaskByDateToState(event);
    } else if (event is InsertTask) {
      yield* _mapInsertTaskToState(event);
    } else if (event is UpdateTask) {
      yield* _mapUpdateTaskToState(event);
    } else if (event is DeleteTask) {
      yield* _mapDeleteTaskToState(event);
    }
  }

  Stream<TaskState> _mapGetTaskToState(GetTask event) async* {
    yield TaskLoading();
    try {
      final TaskEntity entity = await _taskRepository.getAllTasks();
      yield TaskSuccess(entity: entity);
    } catch (e) {
      yield TaskFailure(message: e.toString());
    }
  }

  Stream<TaskState> _mapWatchTaskToState(WatchTask event) async* {
    final Stream<TaskWithCategoryEntity> entity = _taskRepository.watchAllTasks();
    yield TaskStream(entity: entity);
  }

  Stream<TaskState> _mapWatchTaskByStatusToState(WatchTaskByStatus event) async* {
    final Stream<TaskWithCategoryEntity> entity = _taskRepository.watchAllTaskByStatus(event.statusType);
    yield TaskStream(entity: entity);
  }

  Stream<TaskState> _mapWatchTaskByDateToState(WatchTaskByDate event) async* {
    final Stream<TaskWithCategoryEntity> entity = _taskRepository.watchAllTaskByDate(event.dateTime);
    yield TaskStream(entity: entity);
  }

  Stream<TaskState> _mapWatchOnGoingTaskToState(WatchOnGoingTask event) async* {
    final Stream<TaskWithCategoryEntity> entity = _taskRepository.watchOnGoingTasks();
    yield OnGoingTaskStream(entity: entity);
  }

  Stream<TaskState> _mapWatchCompletedTaskToState(WatchCompletedTask event) async* {
    final Stream<TaskWithCategoryEntity> entity = _taskRepository.watchCompletedTasks();
    yield CompletedTaskStream(entity: entity);
  }

  Stream<TaskState> _mapWatchTaskByCategoryToState(
      WatchTaskByCategory event) async* {
    final Stream<TaskWithCategoryEntity> entity =
        _taskRepository.watchAllTaskByCategory(event.id);
    yield TaskStream(entity: entity);
  }

  Stream<TaskState> _mapInsertTaskToState(InsertTask event) async* {
    _taskRepository.insertNewTask(event.taskItemEntity);
  }

  Stream<TaskState> _mapUpdateTaskToState(UpdateTask event) async* {
    _taskRepository.updateTask(event.taskItemEntity);
  }

  Stream<TaskState> _mapDeleteTaskToState(DeleteTask event) async* {
    _taskRepository.deleteTask(event.id);
  }
}
