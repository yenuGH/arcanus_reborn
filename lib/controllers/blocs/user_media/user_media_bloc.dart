import 'dart:async';
import 'dart:developer';

import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/anilist_user.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_media_event.dart';
part 'user_media_state.dart';

class UserMediaBloc extends Bloc<UserMediaEvent, UserMediaState> {
  UserMediaBloc() : super(UserMediaInitialState()) {
    on<UserMediaInitialEvent>(userMediaInitialEvent);
    on<UserMediaInitializeEvent>(userMediaInitializeEvent);
    on<UserMediaLoadingEvent>(userMediaLoadingEvent);
    on<UserMediaLoadedEvent>(userMediaLoadedEvent);
    on<UserMediaErrorEvent>(userMediaErrorEvent);
  }

  FutureOr<void> userMediaInitialEvent(UserMediaInitialEvent event, Emitter<UserMediaState> emit) async {
    emit(UserMediaInitialState());
    add(UserMediaInitializeEvent());
  }

  FutureOr<void> userMediaInitializeEvent(UserMediaInitializeEvent event, Emitter<UserMediaState> emit) async {
    emit(UserMediaIntializingState());
    
    var anilistUserBox = Hive.box('anilistUser');
    if (anilistUserBox.isEmpty) {
      AnilistUser anilistUser = await AnilistClient().userQuery();
      
      anilistUserBox.put("anilistUserId", anilistUser.getAnilistUserId());
      anilistUserBox.put("anilistUserName", anilistUser.getAnilistUserName());
      anilistUserBox.put("anilistUserAvatarLarge", anilistUser.getAnilistUserAvatarLarge());
      anilistUserBox.put("anilistUserAvatarMedium", anilistUser.getAnilistUserAvatarMedium());
      anilistUserBox.put("anilistUserBannerImage", anilistUser.getAnilistUserBannerImage());
    }

    log("UserID: ${anilistUserBox.get("anilistUserId")}");
    log("UserName: ${anilistUserBox.get("anilistUserName")}");

    add(UserMediaLoadingEvent());
  }

  FutureOr<void> userMediaLoadingEvent(UserMediaLoadingEvent event, Emitter<UserMediaState> emit) async {
    emit(UserMediaLoadingState());

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

    add(UserMediaLoadedEvent());
  }

  FutureOr<void> userMediaLoadedEvent(UserMediaLoadedEvent event, Emitter<UserMediaState> emit) async {
    emit(UserMediaLoadedState());
  }

  FutureOr<void> userMediaErrorEvent(UserMediaErrorEvent event, Emitter<UserMediaState> emit) async {
    emit(UserMediaErrorState());
  }
  
}
