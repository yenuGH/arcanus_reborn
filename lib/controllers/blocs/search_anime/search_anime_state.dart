part of 'search_anime_bloc.dart';

sealed class SearchAnimeState extends Equatable {
  const SearchAnimeState();
  
  @override
  List<Object> get props => [];
}

final class SearchAnimeInitialState extends SearchAnimeState {}

final class SearchAnimeLoadingState extends SearchAnimeState {}

final class SearchAnimeLoadedState extends SearchAnimeState {
  final List<AnimeResult> result;
  const SearchAnimeLoadedState({required this.result});

  @override
  List<Object> get props => [result];
}

final class SearchAnimeErrorState extends SearchAnimeState {}
