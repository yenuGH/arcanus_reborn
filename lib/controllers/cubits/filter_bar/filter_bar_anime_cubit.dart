import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';

part 'filter_bar_anime_state.dart';

class FilterBarAnimeCubit extends Cubit<FilterBarAnimeState> {
  FilterBarAnimeCubit() : super(FilterBarAnimeWatching());
}
