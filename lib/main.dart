import 'package:arcanus_reborn/constants/arcanus_theme.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  AnilistClient anilistClient = AnilistClient();
  runApp(MyApp(client: anilistClient.graphQLClient));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.client});

  final GraphQLClient client;

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
      //home: const HomePage(title: "arcanus"),
      initialRoute: "/home_page",
      onGenerateRoute: AppRoutes().onGenerateRoute,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
