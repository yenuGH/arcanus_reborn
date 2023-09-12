part of 'media_entry_bloc.dart';

sealed class MediaEntryEvent extends Equatable {
  const MediaEntryEvent();

  @override
  List<Object> get props => [];
}

final class MediaEntryInitialEvent extends MediaEntryEvent {
  final dynamic mediaResult;

  const MediaEntryInitialEvent(this.mediaResult);

  @override
  List<Object> get props => [mediaResult];
}

final class MediaEntryUpdateStatusEvent extends MediaEntryEvent {}

final class MediaEntryProgressUpdateEvent extends MediaEntryEvent {}

final class MediaEntrySaveEvent extends MediaEntryEvent {}
