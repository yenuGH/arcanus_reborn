import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_bar_state.dart';

class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarAnime()); // the default state of the tab bar will be set to the anime tab

  void animeTab() {
    print("anime tab activated");
    emit(TabBarAnime());
  } // this will emit the anime tab
  void mangaTab() {
    print("manga tab activated");
    emit(TabBarManga());
  } // this will emit the manga tab
}