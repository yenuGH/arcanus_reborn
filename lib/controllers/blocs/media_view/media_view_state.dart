part of 'media_view_bloc.dart';

sealed class MediaViewState extends Equatable {
  const MediaViewState();
  
  @override
  List<Object> get props => [];
}

final class MediaViewInitial extends MediaViewState {}
