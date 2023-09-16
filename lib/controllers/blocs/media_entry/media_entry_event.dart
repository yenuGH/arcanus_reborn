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

final class MediaEntryStatusUpdateEvent extends MediaEntryEvent {}

final class MediaEntryProgressUpdateEvent extends MediaEntryEvent {}

final class MediaEntryPageUpdateEvent extends MediaEntryEvent {}

final class MediaEntrySaveEvent extends MediaEntryEvent {
  final String? status;
  final int progress;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final double score;

  const MediaEntrySaveEvent(this.status, this.progress, this.startedAt, this.completedAt, this.score);

  @override
  List<Object> get props => [status!, progress, startedAt!, completedAt!, score];
}
