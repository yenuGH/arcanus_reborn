import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_bar_manga_state.dart';

class FilterBarMangaCubit extends Cubit<FilterBarMangaState> {
  FilterBarMangaCubit() : super(FilterBarMangaInitial());

  void readingTab() {
    log("Manga: readingTab");
    emit(FilterBarMangaReading());
  }

  void planningTab() {
    log("Manga: planningTab");
    emit(FilterBarMangaPlanning());
  }

  void completedTab() {
    log("Manga: completedTab");
    emit(FilterBarMangaCompleted());
  }

  void droppedTab() {
    log("Manga: droppedTab");
    emit(FilterBarMangaDropped());
  }
}
