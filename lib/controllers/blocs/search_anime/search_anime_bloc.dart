import 'dart:async';

import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_anime_event.dart';
part 'search_anime_state.dart';

class SearchAnimeBloc extends Bloc<SearchAnimeEvent, SearchAnimeState> {
  SearchAnimeBloc() : super(SearchAnimeInitial()) {
    on<SearchAnimeInitialEvent>(searchAnimeInitialEvent);
    on<SearchAnimeNewQueryEvent>(searchAnimeNewQueryEvent);
  }

  FutureOr<void> searchAnimeInitialEvent(SearchAnimeInitialEvent event, Emitter<SearchAnimeState> emit) {
    emit(SearchAnimeInitial());
  }

  FutureOr<void> searchAnimeNewQueryEvent(SearchAnimeNewQueryEvent event, Emitter<SearchAnimeState> emit) {
    print("The query is: " + event.query);
    emit(SearchAnimeLoaded(result: AnilistClient().searchAnimeQueryResult(event.query)));
  }
}
