part of 'search_media_bloc.dart';

sealed class SearchMediaState extends Equatable {
  const SearchMediaState();
  
  @override
  List<Object> get props => [];
}

final class SearchMediaInitialState extends SearchMediaState {}

final class SearchMediaEmptyState extends SearchMediaState {}

final class SearchMediaLoadingState extends SearchMediaState {}

final class SearchMediaLoadedState extends SearchMediaState {
  final List<dynamic> result;
  const SearchMediaLoadedState({required this.result});

  @override
  List<Object> get props => [result];
}

final class SearchMediaErrorState extends SearchMediaState {}
