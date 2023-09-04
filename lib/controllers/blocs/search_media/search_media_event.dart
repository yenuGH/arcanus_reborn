part of 'search_media_bloc.dart';

sealed class SearchMediaEvent extends Equatable {
  const SearchMediaEvent();

  @override
  List<Object> get props => [];
}

final class SearchMediaInitialEvent extends SearchMediaEvent {}

final class SearchMediaNewQueryEvent extends SearchMediaEvent{
  final String query;
  const SearchMediaNewQueryEvent({required this.query});
}