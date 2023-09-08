import 'package:arcanus_reborn/controllers/blocs/anime_filter/anime_filter_bloc.dart';
import 'package:arcanus_reborn/controllers/cubits/anilist_login/anilist_login_cubit.dart';
import 'package:arcanus_reborn/controllers/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:arcanus_reborn/controllers/blocs/search_media/search_media_bloc.dart';
import 'package:arcanus_reborn/pages/about_page.dart';
import 'package:arcanus_reborn/pages/home_page.dart';
import 'package:arcanus_reborn/pages/login_page.dart';
import 'package:arcanus_reborn/pages/search_page.dart';
import 'package:arcanus_reborn/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  final TabBarCubit tabBarCubit = TabBarCubit();
  final AnimeFilterBloc animeFilterBloc = AnimeFilterBloc();
  final AnilistLoginCubit anilistLoginCubit = AnilistLoginCubit();
  final SearchMediaBloc searchMediaBloc = SearchMediaBloc();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/login_page":
        {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: anilistLoginCubit,
              child: const LoginPage(),
            ),
          );
        }
      case "/home_page":
        {
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: tabBarCubit),
                  BlocProvider.value(value: animeFilterBloc),
                ],
                child: const HomePage(
                  title: "arcanus",
                )),
          );
        }
      case "/search_page":
        {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: searchMediaBloc,
              child: const SearchPage(),
            ),
          );
        }
      case "/settings_page":
        {
          return MaterialPageRoute(
            builder: (_) => const SettingsPage(),
          );
        }
      case "/about_page":
        {
          return MaterialPageRoute(
            builder: (_) => const AboutPage(),
          );
        }
      default:
        {
          return null;
        }
    }
  }
}
