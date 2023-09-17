part of 'media_view_bloc.dart';

sealed class MediaViewEvent extends Equatable {
  const MediaViewEvent();

  @override
  List<Object> get props => [];
}

final class MediaViewInitialEvent extends MediaViewEvent {}

final class MediaViewReloadEvent extends MediaViewEvent {}

final class MediaViewUpdateEvent extends MediaViewEvent {}
