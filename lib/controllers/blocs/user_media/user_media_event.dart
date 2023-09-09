part of 'user_media_bloc.dart';

sealed class UserMediaEvent extends Equatable {
  const UserMediaEvent();

  @override
  List<Object> get props => [];
}

final class UserMediaInitialEvent extends UserMediaEvent {}

final class UserMediaLoadingEvent extends UserMediaEvent {}
