part of 'search_anime_bloc.dart';

sealed class SearchAnimeEvent extends Equatable {
  const SearchAnimeEvent();

  @override
  List<Object> get props => [];
}

final class SearchAnimeInitialEvent extends SearchAnimeEvent {}

final class SearchAnimeNewQueryEvent extends SearchAnimeEvent{
  final String query;
  const SearchAnimeNewQueryEvent({required this.query});
}