import 'dart:async';

import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_media_event.dart';
part 'search_media_state.dart';

class SearchMediaBloc extends Bloc<SearchMediaEvent, SearchMediaState> {
  SearchMediaBloc() : super(SearchMediaInitialState()) {
    on<SearchMediaInitialEvent>(searchMediaInitialEvent);
    on<SearchMediaNewQueryEvent>(searchMediaNewQueryEvent);
  }

  FutureOr<void> searchMediaInitialEvent(SearchMediaInitialEvent event, Emitter<SearchMediaState> emit) async {

  }

  Future<FutureOr<void>> searchMediaNewQueryEvent(SearchMediaNewQueryEvent event, Emitter<SearchMediaState> emit) async {
    emit(SearchMediaLoadingState());
    final List<AnimeResult> searchResultAnime = await AnilistClient().searchAnimeQueryResult(event.query);
    //final List<SearchResult> searchResultManga = await AnilistClient().searchMangaQueryResult(event.query);

    List<dynamic> searchResultAnimeManga = [];
    searchResultAnimeManga.addAll(searchResultAnime);
    //searchResultAnimeManga.addAll(searchResultManga);

    emit(SearchMediaLoadedState(result: searchResultAnimeManga));
  }
}
