import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anime_filter_event.dart';
part 'anime_filter_state.dart';

class AnimeFilterBloc extends Bloc<AnimeFilterEvent, AnimeFilterState> {
  AnimeFilterBloc() : super(AnimeFilterInitial()) {
    on<AnimeFilterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
