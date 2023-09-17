import 'dart:async';
import 'dart:developer';

import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'media_view_event.dart';
part 'media_view_state.dart';

class MediaViewBloc extends Bloc<MediaViewEvent, MediaViewState> {
  MediaViewBloc() : super(MediaViewInitialState()) {
    on<MediaViewInitialEvent>(mediaViewIntialEvent);
    on<MediaViewReloadEvent>(mediaViewReloadEvent);
    on<MediaViewUpdateEvent>(mediaViewUpdateEvent);
  }

  FutureOr<void> mediaViewIntialEvent(MediaViewInitialEvent event, Emitter<MediaViewState> emit) async {
    emit(MediaViewInitialState());
  }

  FutureOr<void> mediaViewReloadEvent(MediaViewReloadEvent event, Emitter<MediaViewState> emit) async {
    emit(MediaViewReloadingState());

    await AnilistClient().reloadLists();
   
    emit(MediaViewReloadedState());
  }

  FutureOr<void> mediaViewUpdateEvent(MediaViewUpdateEvent event, Emitter<MediaViewState> emit) async {
    emit(MediaViewUpdateState());
  }
}
