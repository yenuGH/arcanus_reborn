part of 'media_entry_bloc.dart';

sealed class MediaEntryState extends Equatable {
  const MediaEntryState();
  
  @override
  List<Object> get props => [];
}

final class MediaEntryInitialState extends MediaEntryState {}

final class MediaEntryLoadingState extends MediaEntryState {}

final class MediaEntryLoadedState extends MediaEntryState {}

final class MediaEntryErrorState extends MediaEntryState {}

final class MediaEntrySavingState extends MediaEntryState {}

final class MediaEntrySavedState extends MediaEntryState {}
