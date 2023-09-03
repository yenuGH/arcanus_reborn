import 'package:arcanus_reborn/controllers/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:arcanus_reborn/controllers/blocs/search_anime/search_anime_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static get blocProviders => [
    BlocProvider(create: (context) => TabBarCubit()),
    BlocProvider(create: (context) => SearchAnimeBloc())
  ];
}