import 'dart:developer';

import 'package:arcanus_reborn/constants/search_type.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_bar_state.dart';

class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarAnime()); // the default state of the tab bar will be set to the anime tab

  void animeTab() {
    log("anime tab activated");
    SearchType().isAnime = true;
    emit(TabBarAnime());
  } // this will emit the anime tab

  void mangaTab() {
    log("manga tab activated");
    SearchType().isAnime = false;
    emit(TabBarManga());
  } // this will emit the manga tab

  void reloadTab() {
    emit(TabBarReload());
  }
}
