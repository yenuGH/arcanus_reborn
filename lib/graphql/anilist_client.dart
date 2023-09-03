import 'package:arcanus_reborn/graphql/anilist_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

  Future<QueryResult> searchAnimeQueryResult(String query) async {
    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.searchAnimeQuery),
        variables: {
          'query': query,
        },
      ),
    );

    print("The result is: " + result.data.toString());

    return result;
  }
  
}