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
}
