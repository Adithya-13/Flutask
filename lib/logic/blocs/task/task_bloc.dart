import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/repositories/repositories.dart';

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
    } else if (event is WatchTaskByCategory) {
      yield* _mapWatchTaskByCategoryToState(event);
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
    final Stream<TaskEntity> entity = _taskRepository.watchAllTasks();
    yield TaskStream(entity: entity);
  }

  Stream<TaskState> _mapWatchTaskByCategoryToState(
      WatchTaskByCategory event) async* {
    final Stream<TaskEntity> entity =
        _taskRepository.getAllTaskByCategory(event.id);
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
