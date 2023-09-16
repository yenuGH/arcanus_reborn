import 'package:arcanus_reborn/controllers/blocs/user_media/user_media_bloc.dart';
import 'package:arcanus_reborn/controllers/cubits/anilist_login/anilist_login_cubit.dart';
import 'package:arcanus_reborn/controllers/cubits/filter_bar/anime/filter_bar_anime_cubit.dart';
import 'package:arcanus_reborn/controllers/cubits/filter_bar/manga/filter_bar_manga_cubit.dart';
import 'package:arcanus_reborn/controllers/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:arcanus_reborn/controllers/blocs/search_media/search_media_bloc.dart';
import 'package:arcanus_reborn/pages/about_page.dart';
import 'package:arcanus_reborn/pages/home_page.dart';
import 'package:arcanus_reborn/pages/loading_page.dart';
import 'package:arcanus_reborn/pages/login_page.dart';
import 'package:arcanus_reborn/pages/media_entry_page.dart.dart';
import 'package:arcanus_reborn/pages/media_info_page.dart';
import 'package:arcanus_reborn/pages/search_page.dart';
import 'package:arcanus_reborn/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  final TabBarCubit tabBarCubit = TabBarCubit();
  final FilterBarAnimeCubit filterBarAnimeCubit = FilterBarAnimeCubit();
  final FilterBarMangaCubit filterBarMangaCubit = FilterBarMangaCubit();
  final AnilistLoginCubit anilistLoginCubit = AnilistLoginCubit();
  final SearchMediaBloc searchMediaBloc = SearchMediaBloc();
  final UserMediaBloc userMediaBloc = UserMediaBloc();

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
      case "/loading_page":
        {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: userMediaBloc,
              child: const LoadingPage(),
            ),
          );
        }
      case "/home_page":
        {
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: tabBarCubit),
                BlocProvider.value(value: filterBarAnimeCubit),
                BlocProvider.value(value: filterBarMangaCubit),
                BlocProvider.value(value: userMediaBloc),
              ],
              child: const HomePage(
                title: "arcanus",
              )
            ),
          );
        }
      case "/media_info_page":
      {
        final arguments = routeSettings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => MediaInfoPage(
            mediaResult: arguments["mediaResult"],
          ),
        );
      }
      case "/media_entry_page" :
      {
        final arguments = routeSettings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: tabBarCubit,
            child: MediaEntryPage(
              mediaResult: arguments["mediaResult"],
            ),
          ),
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
