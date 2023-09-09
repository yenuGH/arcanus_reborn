import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_media_event.dart';
part 'user_media_state.dart';

class UserMediaBloc extends Bloc<UserMediaEvent, UserMediaState> {
  UserMediaBloc() : super(UserMediaInitialState()) {
    on<UserMediaInitialEvent>(userMediaInitialEvent);
    on<UserMediaLoadingEvent>(userMediaLoadingEvent);
  }

  FutureOr<void> userMediaInitialEvent(UserMediaInitialEvent event, Emitter<UserMediaState> emit) async {
    emit(UserMediaInitialState());
    await Future.delayed(const Duration(seconds: 2));
    emit(UserMediaLoadingState());
  }

  FutureOr<void> userMediaLoadingEvent(UserMediaLoadingEvent event, Emitter<UserMediaState> emit) async {

  }
  
}
