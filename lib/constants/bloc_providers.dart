import 'package:arcanus_reborn/controllers/blocs/search_media/search_media_bloc.dart';
import 'package:arcanus_reborn/controllers/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static get blocProviders => [
    BlocProvider(create: (context) => TabBarCubit()),
    BlocProvider(create: (context) => SearchMediaBloc())
  ];
}