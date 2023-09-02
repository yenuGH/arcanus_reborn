import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AnilistClient {
  static late AnilistClient _instance;
  
  final HttpLink httpLink = HttpLink("https://graphql.anilist.co/");
  final ValueNotifier<GraphQLClient> graphQLClient = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink("https://graphql.anilist.co/"),
    ),
  );

  AnilistClient._internal();

  factory AnilistClient() {
    _instance = AnilistClient._internal();
    return _instance;
  }
}