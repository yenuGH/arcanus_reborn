part of 'filter_bar_manga_cubit.dart';

sealed class FilterBarMangaState extends Equatable {
  const FilterBarMangaState();

  @override
  List<Object> get props => [];
}

final class FilterBarMangaInitial extends FilterBarMangaState {}

final class FilterBarMangaReading extends FilterBarMangaState {}

final class FilterBarMangaPlanning extends FilterBarMangaState {}

final class FilterBarMangaCompleted extends FilterBarMangaState {}

final class FilterBarMangaDropped extends FilterBarMangaState {}