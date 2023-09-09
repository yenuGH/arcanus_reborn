part of 'user_media_bloc.dart';

sealed class UserMediaState extends Equatable {
  const UserMediaState();
  
  @override
  List<Object> get props => [];
}

final class UserMediaInitialState extends UserMediaState {}

final class UserMediaIntializingState extends UserMediaState {}

final class UserMediaLoadingState extends UserMediaState {}

final class UserMediaLoadedState extends UserMediaState {}
