import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'media_entry_event.dart';
part 'media_entry_state.dart';

class MediaEntryBloc extends Bloc<MediaEntryEvent, MediaEntryState> {
  MediaEntryBloc() : super(MediaEntryInitialState()) {
    on<MediaEntryInitialEvent>(mediaEntryInitialEvent);
  }

  FutureOr<void> mediaEntryInitialEvent(MediaEntryInitialEvent event, Emitter<MediaEntryState> emit) async {
    emit(MediaEntryLoadingState());

    

    emit(MediaEntryLoadedState());
  }
}
