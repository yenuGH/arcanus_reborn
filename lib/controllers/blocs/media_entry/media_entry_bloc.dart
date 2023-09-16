import 'dart:async';

import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'media_entry_event.dart';
part 'media_entry_state.dart';

class MediaEntryBloc extends Bloc<MediaEntryEvent, MediaEntryState> {
  MediaEntryBloc() : super(MediaEntryInitialState()) {
    on<MediaEntryInitialEvent>(mediaEntryInitialEvent);
    on<MediaEntryPageUpdateEvent>(mediaEntryPageUpdateEvent);
    on<MediaEntrySaveEvent>(mediaEntrySaveEvent);
  }

  FutureOr<void> mediaEntryInitialEvent(MediaEntryInitialEvent event, Emitter<MediaEntryState> emit) async {
    emit(MediaEntryLoadingState());

    final dynamic mediaResult = event.mediaResult;
    MediaResult mediaEntryQueryResult = await AnilistClient().mediaEntryQuery(mediaResult.mediaType, mediaResult.id);

    emit(MediaEntryLoadedState(mediaEntryQueryResult));
  }

  FutureOr<void> mediaEntryPageUpdateEvent(MediaEntryPageUpdateEvent event, Emitter<MediaEntryState> emit) async {
    emit(MediaEntryPageUpdateState());
    emit(MediaEntryIdleState());
  }

  FutureOr<void> mediaEntrySaveEvent(MediaEntrySaveEvent event, Emitter<MediaEntryState> emit) async {
    emit(MediaEntrySavingState());

    // log("Saving media entry: ${event.status}, ${event.progress}, ${event.startedAt}, ${event.completedAt}, ${event.score}");

    int mediaId = event.mediaId;

    String status;
    if (event.status == "WATCHING" || event.status == "READING") {
      status = "CURRENT";
    } 
    else {
      status = event.status!;
    }

    int progress = event.progress;

    double score = event.score;

    Map<String, dynamic> startedAt = {
      "year": event.startedAt?.year,
      "month": event.startedAt?.month,
      "day": event.startedAt?.day,
    };

    Map<String, dynamic> completedAt = {
      "year": event.completedAt?.year,
      "month": event.completedAt?.month,
      "day": event.completedAt?.day,
    };

    await AnilistClient().mediaEntryMutation(
      mediaId,
      status,
      progress,
      score,
      startedAt,
      completedAt,
    );

    emit(MediaEntrySavedState());
  }
}
