import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'media_view_event.dart';
part 'media_view_state.dart';

class MediaViewBloc extends Bloc<MediaViewEvent, MediaViewState> {
  MediaViewBloc() : super(MediaViewInitial()) {
    on<MediaViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
