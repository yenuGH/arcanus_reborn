import 'dart:async';

import 'package:arcanus_reborn/constants/search_type.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/search_anime_result.dart';
import 'package:arcanus_reborn/models/search_manga_result.dart';
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

    if (SearchType().isAnime == true){
      final List<SearchAnimeResult> searchResultAnime = await AnilistClient().searchAnimeQueryResult(event.query);

      if (searchResultAnime.isEmpty) {
        emit(SearchMediaEmptyState());
        return null;
      }

      emit(SearchMediaLoadedState(result: searchResultAnime));
    }
    else {
      final List<SearchMangaResult> searchResultManga = await AnilistClient().searchMangaQueryResult(event.query);

      if (searchResultManga.isEmpty) {
        emit(SearchMediaEmptyState());
        return null;
      }

      emit(SearchMediaLoadedState(result: searchResultManga));
    }

  }
}
