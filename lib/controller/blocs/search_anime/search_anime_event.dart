part of 'search_anime_bloc.dart';

sealed class SearchAnimeEvent extends Equatable {
  const SearchAnimeEvent();

  @override
  List<Object> get props => [];
}

final class SearchAnimeNewQuery extends SearchAnimeEvent{
  final String query;
  const SearchAnimeNewQuery({required this.query});
}