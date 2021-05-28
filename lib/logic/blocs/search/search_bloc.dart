import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/data/repositories/repositories.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TaskRepository _taskRepository;

  SearchBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is SearchTask){
      yield* _mapSearchTaskToState(event);
    }
  }

  Stream<SearchState> _mapSearchTaskToState(SearchTask event) async* {
    final Stream<TaskWithCategoryEntity> entity = _taskRepository.searchTasks(event.searchQuery);
    yield SearchStream(entity: entity);
  }
}
