import 'package:arcanus_reborn/constants/arcanus_theme.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arcanus',
      theme: ArcanusTheme().arcanusTheme,
      initialRoute: "/login_page",
      onGenerateRoute: AppRoutes().onGenerateRoute,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
