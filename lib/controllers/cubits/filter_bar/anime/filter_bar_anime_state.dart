part of 'filter_bar_anime_cubit.dart';

sealed class FilterBarAnimeState extends Equatable {
  const FilterBarAnimeState();

  @override
  List<Object> get props => [];
}

final class FilterBarAnimeInitial extends FilterBarAnimeState {

}

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