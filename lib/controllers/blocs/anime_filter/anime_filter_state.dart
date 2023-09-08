part of 'anime_filter_bloc.dart';

sealed class AnimeFilterState extends Equatable {
  const AnimeFilterState();
  
  @override
  List<Object> get props => [];
}

final class AnimeFilterInitial extends AnimeFilterState {}
