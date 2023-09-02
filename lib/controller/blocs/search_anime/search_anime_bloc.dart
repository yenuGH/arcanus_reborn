import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_anime_event.dart';
part 'search_anime_state.dart';

class SearchAnimeBloc extends Bloc<SearchAnimeEvent, SearchAnimeState> {
  SearchAnimeBloc() : super(SearchAnimeInitial()) {
    on<SearchAnimeNewQuery>(searchAnimeNewQueryEvent);
  }

  FutureOr<void> searchAnimeNewQueryEvent(SearchAnimeNewQuery event, Emitter<SearchAnimeState> emit) {
    print("The query is: " + event.query);
  }
}
