import 'package:arcanus_reborn/pages/home_page.dart';
import 'package:arcanus_reborn/pages/search_page.dart';
import 'package:arcanus_reborn/pages/settings_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case "/home_page": {
        return MaterialPageRoute(
          builder: (_) => const HomePage(title: "arcanus",),
        );
      }
      case "/search_page": {
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
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