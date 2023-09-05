part of 'anilist_login_cubit.dart';

sealed class AnilistLoginState extends Equatable {
  const AnilistLoginState();

  @override
  List<Object> get props => [];
}

final class AnilistLoginInitialState extends AnilistLoginState {}

final class AnilistLoginSavedState extends AnilistLoginState {}

final class AnilistLoginNotSavedState extends AnilistLoginState {}

final class AnilistLoginPressedState extends AnilistLoginState {}
