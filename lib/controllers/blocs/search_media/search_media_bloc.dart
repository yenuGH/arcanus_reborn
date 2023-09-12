import 'dart:async';
import 'dart:developer';

import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/constants/search_type.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_media_event.dart';
part 'search_media_state.dart';

class SearchMediaBloc extends Bloc<SearchMediaEvent, SearchMediaState> {
  SearchMediaBloc() : super(SearchMediaInitialState()) {
    on<SearchMediaInitialEvent>(searchMediaInitialEvent);
    on<SearchMediaEmptyEvent>(searchMediaEmptyEvent);
    on<SearchMediaNewQueryEvent>(searchMediaNewQueryEvent);
  }

  FutureOr<void> searchMediaInitialEvent(SearchMediaInitialEvent event, Emitter<SearchMediaState> emit) async {

  }

  FutureOr<void> searchMediaEmptyEvent(SearchMediaEmptyEvent event, Emitter<SearchMediaState> emit) async {
    emit(SearchMediaEmptyState());
  }

  Future<FutureOr<void>> searchMediaNewQueryEvent(SearchMediaNewQueryEvent event, Emitter<SearchMediaState> emit) async {
    emit(SearchMediaLoadingState());

    List<MediaResult> mediaResults;
    if (SearchType().isAnime == true){
      mediaResults = await AnilistClient().mediaQuery(MediaType.ANIME, event.query);
    } 
    else {
      mediaResults = await AnilistClient().mediaQuery(MediaType.MANGA, event.query);
    }

    if (mediaResults.isEmpty){
      log("No results found.");
      emit(SearchMediaEmptyState());
    }

    emit(SearchMediaLoadedState(result: mediaResults));
  }
}
