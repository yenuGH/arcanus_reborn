import 'dart:async';
import 'dart:developer';

import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'media_entry_event.dart';
part 'media_entry_state.dart';

class MediaEntryBloc extends Bloc<MediaEntryEvent, MediaEntryState> {
  MediaEntryBloc() : super(MediaEntryInitialState()) {
    on<MediaEntryInitialEvent>(mediaEntryInitialEvent);
  }

  FutureOr<void> mediaEntryInitialEvent(MediaEntryInitialEvent event, Emitter<MediaEntryState> emit) async {
    emit(MediaEntryLoadingState());

    final dynamic mediaResult = event.mediaResult;
    MediaResult mediaEntryQueryResult = await AnilistClient().mediaEntryQuery(mediaResult.mediaType, mediaResult.id);

    log("Media name: ${mediaEntryQueryResult.titleUserPreferred}");
    log("Media status: ${mediaEntryQueryResult.userStatus}");
    log("Media progress: ${mediaEntryQueryResult.userProgress}");
    log("Media score: ${mediaEntryQueryResult.userScore}");

    emit(MediaEntryLoadedState());
  }
}
