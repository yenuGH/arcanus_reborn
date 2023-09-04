import 'package:arcanus_reborn/controllers/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:arcanus_reborn/controllers/blocs/search_media/search_media_bloc.dart';
import 'package:arcanus_reborn/pages/home_page.dart';
import 'package:arcanus_reborn/pages/login_page.dart';
import 'package:arcanus_reborn/pages/search_page.dart';
import 'package:arcanus_reborn/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  final TabBarCubit tabBarCubit = TabBarCubit();
  final SearchMediaBloc searchMediaBloc = SearchMediaBloc();

  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case "/login_page": {
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      }
      case "/home_page": {
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: tabBarCubit,
            child: const HomePage(title: "arcanus",)
          ),
        );
      }
      case "/search_page": {
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: searchMediaBloc,
            child: const SearchPage(),
          ),
        );
      }
      case "/settings_page": {
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      }
      default: {
        return null;
      }
    }
  }
}