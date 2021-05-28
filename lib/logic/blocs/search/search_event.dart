part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchTask extends SearchEvent {
  final String searchQuery;

  SearchTask({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class SetInitialSearch extends SearchEvent {}
