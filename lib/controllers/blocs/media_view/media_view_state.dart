part of 'media_view_bloc.dart';

sealed class MediaViewState extends Equatable {
  const MediaViewState();
  
  @override
  List<Object> get props => [];
}

final class MediaViewInitialState extends MediaViewState {}

final class MediaViewReloadingState extends MediaViewState {}

final class MediaViewReloadedState extends MediaViewState {}

final class MediaViewReloadState extends MediaViewState {}

final class MediaViewUpdateState extends MediaViewState {}

final class MediaViewIdleState extends MediaViewState {}

