// ignore_for_file: constant_identifier_names

import 'package:arcanus_reborn/graphql/anilist_queries.dart';
import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

enum MediaType {
  ANIME,
  MANGA,
}

class AnilistClient {
  static late AnilistClient _instance;
  
  final HttpLink httpLink = HttpLink(
    "https://graphql.anilist.co/",
  );

  final GraphQLClient graphQLClient = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink("https://graphql.anilist.co/"),
  );

  AnilistClient._internal();

  factory AnilistClient() {
    _instance = AnilistClient._internal();
    return _instance;
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
  
}