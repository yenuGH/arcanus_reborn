import 'dart:async';

import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_anime_event.dart';
part 'search_anime_state.dart';

class SearchAnimeBloc extends Bloc<SearchAnimeEvent, SearchAnimeState> {
  SearchAnimeBloc() : super(SearchAnimeInitialState()) {
    on<SearchAnimeInitialEvent>(searchAnimeInitialEvent);
    on<SearchAnimeNewQueryEvent>(searchAnimeNewQueryEvent);
  }

  FutureOr<void> searchAnimeInitialEvent(SearchAnimeInitialEvent event, Emitter<SearchAnimeState> emit) async {
    //print("Initial event for search anime");
    emit(SearchAnimeLoadingState());
  }

  Future<FutureOr<void>> searchAnimeNewQueryEvent(SearchAnimeNewQueryEvent event, Emitter<SearchAnimeState> emit) async {
    //print("The query is: " + event.query);
    final List<AnimeResult> result = await AnilistClient().searchAnimeQueryResult(event.query);

    /* for (int i = 0; i < result.length; i++) {
      result[i].printAnimeResult();
      print("\n");print("\n");print("\n");
    } */

    //print("The state before: " + state.toString());

    emit(SearchAnimeLoadedState(result: result));

    //print("The state after: " + state.toString());
  }
}
