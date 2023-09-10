import 'dart:async';
import 'dart:developer';

import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/anilist_user.dart';
import 'package:arcanus_reborn/models/anime_result.dart';
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

    await Future.delayed(const Duration(seconds: 2));
    
    var anilistUserBox = Hive.box('anilistUser');
    if (anilistUserBox.isEmpty) {
      AnilistUser anilistUser = await AnilistClient().userQuery();
      
      anilistUserBox.put("anilistUserId", anilistUser.getAnilistUserId());
      anilistUserBox.put("anilistUserName", anilistUser.getAnilistUserName());
      anilistUserBox.put("anilistUserAvatarLarge", anilistUser.getAnilistUserAvatarLarge());
      anilistUserBox.put("anilistUserAvatarMedium", anilistUser.getAnilistUserAvatarMedium());
    }

    log("UserID: ${anilistUserBox.get("anilistUserId")}");
    log("UserName: ${anilistUserBox.get("anilistUserName")}");

    add(UserMediaLoadingEvent());
  }

  FutureOr<void> userMediaLoadingEvent(UserMediaLoadingEvent event, Emitter<UserMediaState> emit) async {
    emit(UserMediaLoadingState());

    List<AnimeResult>? userAnimeListCurrent;
    List<AnimeResult>? userAnimeListPlanning;
    List<AnimeResult>? userAnimeListCompleted;
    List<AnimeResult>? userAnimeListDropped;
    List<AnimeResult>? userAnimeListPaused;

    userAnimeListCurrent = await AnilistClient().userAnimeQueryResult("CURRENT");
    userAnimeListPlanning = await AnilistClient().userAnimeQueryResult("PLANNING");
    userAnimeListCompleted = await AnilistClient().userAnimeQueryResult("COMPLETED");
    userAnimeListPaused = await AnilistClient().userAnimeQueryResult("PAUSED");
    userAnimeListDropped = await AnilistClient().userAnimeQueryResult("DROPPED");

    AnilistClient().setUserAnimeLists(
      userAnimeListCurrent,
      userAnimeListPlanning,
      userAnimeListCompleted,
      userAnimeListDropped,
      userAnimeListPaused,
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
