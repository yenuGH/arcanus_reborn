part of 'tab_bar_cubit.dart';

sealed class TabBarState extends Equatable {
  const TabBarState();

  @override
  List<Object> get props => [];
}

final class TabBarAnime extends TabBarState {}

final class TabBarManga extends TabBarState {}

final class TabBarReloading extends TabBarState {}

final class TabBarReloaded extends TabBarState {}
