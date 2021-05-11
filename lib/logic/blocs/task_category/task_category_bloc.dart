import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/repositories/repositories.dart';

part 'task_category_event.dart';

part 'task_category_state.dart';

class TaskCategoryBloc extends Bloc<TaskCategoryEvent, TaskCategoryState> {
  final HomeRepository repository;

  TaskCategoryBloc({required this.repository}) : super(TaskCategoryInitial());

  @override
  Stream<TaskCategoryState> mapEventToState(
    TaskCategoryEvent event,
  ) async* {
    if (event is TaskCategoryFetched) {
      yield* _mapTaskCategoryFetchedToState(event);
    }
  }

  Stream<TaskCategoryState>_mapTaskCategoryFetchedToState(TaskCategoryFetched event) async* {
    yield TaskCategoryLoadData();
    try {
      final TaskCategoryEntity entity = await repository.getTaskCategoryEntity();
      yield TaskCategorySuccess(entity: entity);
    } catch (e) {
      yield TaskCategoryFailure(message: e.toString());
    }
  }
}
