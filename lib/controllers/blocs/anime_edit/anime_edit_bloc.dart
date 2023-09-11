import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anime_edit_event.dart';
part 'anime_edit_state.dart';

class AnimeEditBloc extends Bloc<AnimeEditEvent, AnimeEditState> {
  AnimeEditBloc() : super(AnimeEditInitial()) {
    on<AnimeEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
