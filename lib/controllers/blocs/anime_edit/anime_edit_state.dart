part of 'anime_edit_bloc.dart';

sealed class AnimeEditState extends Equatable {
  const AnimeEditState();
  
  @override
  List<Object> get props => [];
}

final class AnimeEditInitial extends AnimeEditState {}
