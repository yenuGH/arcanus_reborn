part of 'search_anime_bloc.dart';

sealed class SearchAnimeState extends Equatable {
  const SearchAnimeState();
  
  @override
  List<Object> get props => [];
}

final class SearchAnimeInitial extends SearchAnimeState {}

final class SearchAnimeLoading extends SearchAnimeState {}

final class SearchAnimeLoaded extends SearchAnimeState {
  final dynamic result;
  const SearchAnimeLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

final class SearchAnimeError extends SearchAnimeState {}
