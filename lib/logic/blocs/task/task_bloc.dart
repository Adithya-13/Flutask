import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/repositories/repositories.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final HomeRepository repository;

  TaskBloc({required this.repository}) : super(TaskInitial());

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is TaskFetched) {
      yield* _mapTaskFetchedToState(event);
    }
  }

  Stream<TaskState>_mapTaskFetchedToState(TaskFetched event) async* {
    yield TaskLoadData();
    try {
      final TaskEntity entity = await repository.getTaskEntity();
      yield TaskSuccess(entity: entity);
    } catch (e) {
      yield TaskFailure(message: e.toString());
    }
  }
}
