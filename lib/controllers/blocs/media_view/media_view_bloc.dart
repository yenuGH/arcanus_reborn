import 'dart:async';
import 'dart:developer';

import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
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

    //await AnilistClient().reloadLists();

    List<MediaListResult>? userAnimeListCurrent;
    List<MediaListResult>? userAnimeListPlanning;
    List<MediaListResult>? userAnimeListCompleted;
    List<MediaListResult>? userAnimeListDropped;
    List<MediaListResult>? userAnimeListPaused;

    List<MediaListResult>? userMangaListCurrent;
    List<MediaListResult>? userMangaListPlanning;
    List<MediaListResult>? userMangaListCompleted;
    List<MediaListResult>? userMangaListDropped;

    userAnimeListCurrent = await AnilistClient().userMediaListQuery(MediaType.ANIME, "CURRENT");
    userAnimeListPlanning = await AnilistClient().userMediaListQuery(MediaType.ANIME, "PLANNING");
    userAnimeListCompleted = await AnilistClient().userMediaListQuery(MediaType.ANIME, "COMPLETED");
    userAnimeListDropped = await AnilistClient().userMediaListQuery(MediaType.ANIME, "DROPPED");
    userAnimeListPaused = await AnilistClient().userMediaListQuery(MediaType.ANIME, "PAUSED");

    userMangaListCurrent = await AnilistClient().userMediaListQuery(MediaType.MANGA, "CURRENT");
    userMangaListPlanning = await AnilistClient().userMediaListQuery(MediaType.MANGA, "PLANNING");
    userMangaListCompleted = await AnilistClient().userMediaListQuery(MediaType.MANGA, "COMPLETED");
    userMangaListDropped = await AnilistClient().userMediaListQuery(MediaType.MANGA, "DROPPED");
    

    for (MediaListResult mediaListResult in userAnimeListCurrent){
      log(mediaListResult.titleUserPreferred);
    }

    AnilistClient().setUserAnimeLists(
      userAnimeListCurrent,
      userAnimeListPlanning,
      userAnimeListCompleted,
      userAnimeListDropped,
      userAnimeListPaused,
    );

    AnilistClient().setUserMangaLists(
      userMangaListCurrent,
      userMangaListPlanning,
      userMangaListCompleted,
      userMangaListDropped,
    );
   
    emit(MediaViewReloadedState());
  }

  FutureOr<void> mediaViewUpdateEvent(MediaViewUpdateEvent event, Emitter<MediaViewState> emit) async {
    emit(MediaViewUpdateState());
  }
}
