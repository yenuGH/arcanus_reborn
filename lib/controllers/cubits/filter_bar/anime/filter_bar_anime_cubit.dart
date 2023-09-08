import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

part 'filter_bar_anime_state.dart';

class FilterBarAnimeCubit extends Cubit<FilterBarAnimeState> {
  FilterBarAnimeCubit() : super(FilterBarAnimeInitial());

  void watchingTab(){
    log("Anime: watchingTab");
    emit(FilterBarAnimeWatching());
  }
  void planningTab() {
    log("Anime: planningTab");
    emit(FilterBarAnimePlanning());
  }
  void completedTab() {
    log("Anime: completedTab");
    emit(FilterBarAnimeCompleted());
  }
  void pausedTab() {
    log("Anime: pausedTab");
    emit(FilterBarAnimePaused());
  }
  void droppedTab() {
    log("Anime: droppedTab");
    emit(FilterBarAnimeDropped());
  }
}
