part of 'filter_bar_anime_cubit.dart';

@immutable
sealed class FilterBarAnimeState {}

final class FilterBarAnimeWatching extends FilterBarAnimeState {
  
}

final class FilterBarAnimePlanning extends FilterBarAnimeState {

}

final class FilterBarAnimeCompleted extends FilterBarAnimeState {

}

final class FilterBarAnimePaused extends FilterBarAnimeState {

}

final class FilterBarAnimeDropped extends FilterBarAnimeState {

}