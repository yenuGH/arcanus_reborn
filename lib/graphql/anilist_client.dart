// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:arcanus_reborn/graphql/anilist_oauth.dart';
import 'package:arcanus_reborn/graphql/anilist_queries.dart';
import 'package:arcanus_reborn/models/anilist_user.dart';
import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oauth2_client/oauth2_helper.dart';

enum MediaType {
  ANIME,
  MANGA,
}

class AnilistClient {
  static late AnilistClient _instance;
  final tokenBox = Hive.box('userToken');
  
  late OAuth2Helper helper;
  late HttpLink httpLink;
  late AuthLink authLink;
  late Link implicitGrantLink;

  bool isAuthorized = false;

  late GraphQLClient graphQLClient;

  AnilistClient._internal(){
    helper = createAnilistOAuthHelper();
    httpLink  = HttpLink("https://graphql.anilist.co/");
    authLink = AuthLink(getToken: () async => "Bearer ${tokenBox.get("token")}");
    implicitGrantLink = authLink.concat(httpLink);

    graphQLClient = GraphQLClient(cache: GraphQLCache(), link: implicitGrantLink);

    isAuthorized = true; // this constructor will not run if the token is invalid
  }

  factory AnilistClient() {
    _instance = AnilistClient._internal();
    return _instance;
  }

  Future<AnilistUser> userQuery() async {
    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.userQuery),
      ),
    );

    if (result.hasException) {
      log("The exception is: ${result.exception}");
    }

    Map<String, dynamic> resultData = result.data?['Viewer'];

    return AnilistUser.fromJson(resultData);
  }

  Future<List<AnimeResult>> searchAnimeQueryResult(String query) async {
    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.searchAnimeQuery),
        variables: {
          'query': query,
        },
      ),
    );

    if (result.hasException) {
      // print("The exception is: " + result.exception.toString());
    }

    List<dynamic> resultData = result.data?['page']['media'];
    List<AnimeResult> searchResults = [];

    for (int i = 0; i < resultData.length; i++) {
      searchResults.add(AnimeResult.fromJson(resultData[i]));
    }

    return searchResults;
  }

  Future<List<AnimeResult>> userAnimeQueryResult(String status) async {
    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.userAnimeQuery),
        variables: {
          'status': status,
        },
      ),
    );

    if (result.hasException) {
      log("The exception is: ${result.exception}");
    }

    List<dynamic> resultData = result.data?['page']['mediaList'];
    List<AnimeResult> userAnimeResults = [];

    for (int i = 0; i < resultData.length; i++) {
      userAnimeResults.add(AnimeResult.fromJson(resultData[i]));
    }

    return userAnimeResults;
  }
}