// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/graphql/anilist_oauth.dart';
import 'package:arcanus_reborn/graphql/anilist_queries.dart';
import 'package:arcanus_reborn/models/anilist_user.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
import 'package:arcanus_reborn/models/search_anime_result.dart';
import 'package:arcanus_reborn/models/search_manga_result.dart';
import 'package:arcanus_reborn/models/user_anime_result.dart';
import 'package:arcanus_reborn/models/user_manga_result.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class AnilistClient {
  static final AnilistClient _instance = AnilistClient._internal();
  final tokenBox = Hive.box('userToken');
  
  late OAuth2Helper helper;
  late HttpLink httpLink;
  late AuthLink authLink;
  late Link implicitGrantLink;

  List<UserAnimeResult>? userAnimeListCurrent;
  List<UserAnimeResult>? userAnimeListPlanning;
  List<UserAnimeResult>? userAnimeListCompleted;
  List<UserAnimeResult>? userAnimeListDropped;
  List<UserAnimeResult>? userAnimeListPaused;
  List<UserAnimeResult>? userAnimeListAll;

  List<UserMangaResult>? userMangaListCurrent;
  List<UserMangaResult>? userMangaListPlanning;
  List<UserMangaResult>? userMangaListCompleted;
  List<UserMangaResult>? userMangaListDropped;

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

  Future<void> mediaListQuery(MediaType mediaType, String status) async{
    QueryResult queryResult = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.mediaListQuery),
        variables: {
          'userId': Hive.box('anilistUser').get('anilistUserId'),
          'type': mediaType.name,
          'status': MediaListStatus.values.byName(status).name,
        }
      ),
    );

    if (queryResult.hasException) {
      log("The exception is: ${queryResult.exception}");
    }

    List<dynamic> queryResultData = queryResult.data?['MediaListCollection']['lists'];
    List<MediaListResult> mediaListResults = [];

    for (int i = 0; i < queryResultData.length; i++) {
      for (int j = 0; j < queryResultData[i]['entries'].length; j++) {
        mediaListResults.add(MediaListResult.fromJson(queryResultData[i]['entries'][j]));
      }
    }

    log("MediaListResults: ${mediaListResults.length}");
  }

  Future<List<SearchAnimeResult>> searchAnimeQueryResult(String query) async {
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
    List<SearchAnimeResult> searchResults = [];

    for (int i = 0; i < resultData.length; i++) {
      searchResults.add(SearchAnimeResult.fromJson(resultData[i]));
    }

    return searchResults;
  }

  Future<List<SearchMangaResult>> searchMangaQueryResult(String query) async {
    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.searchMangaQuery),
        variables: {
          'query': query,
        },
      ),
    );

    if (result.hasException) {
      // print("The exception is: " + result.exception.toString());
    }

    List<dynamic> resultData = result.data?['page']['media'];
    List<SearchMangaResult> searchResults = [];

    for (int i = 0; i < resultData.length; i++) {
      searchResults.add(SearchMangaResult.fromJson(resultData[i]));
    }

    return searchResults;
  }

  Future<List<UserAnimeResult>> userAnimeQueryResult(String status) async {
    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.userAnimeQuery),
        variables: {
          'userId': Hive.box('anilistUser').get('anilistUserId'),
          'status': MediaListStatus.values.byName(status).name,
        },
      ),
    );

    if (result.hasException) {
      log("The exception is: ${result.exception}");
    }

    List<dynamic> resultData = result.data?['MediaListCollection']['lists'];
    List<UserAnimeResult> userAnimeList = [];

    for (int i = 0; i < resultData.length; i++) {
      for (int j = 0; j < resultData[i]['entries'].length; j++) {
        userAnimeList.add(UserAnimeResult.fromJson(resultData[i]['entries'][j]));
      }
    }

    return userAnimeList;
  }

  Future<List<UserMangaResult>> userMangaQueryResult(String status) async {
    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.userMangaQuery),
        variables: {
          'userId': Hive.box('anilistUser').get('anilistUserId'),
          'status': MediaListStatus.values.byName(status).name,
        },
      ),
    );

    if (result.hasException) {
      log("The exception is: ${result.exception}");
    }

    List<dynamic> resultData = result.data?['MediaListCollection']['lists'];
    List<UserMangaResult> userMangaList = [];

    for (int i = 0; i < resultData.length; i++) {
      for (int j = 0; j < resultData[i]['entries'].length; j++) {
        userMangaList.add(UserMangaResult.fromJson(resultData[i]['entries'][j]));
      }
    }

    return userMangaList;
  }

  void setUserAnimeLists(
    List<UserAnimeResult> userAnimeListCurrent,
    List<UserAnimeResult> userAnimeListPlanning,
    List<UserAnimeResult> userAnimeListCompleted,
    List<UserAnimeResult> userAnimeListDropped,
    List<UserAnimeResult> userAnimeListPaused,
  ) {
    this.userAnimeListCurrent = userAnimeListCurrent;
    this.userAnimeListPlanning = userAnimeListPlanning;
    this.userAnimeListCompleted = userAnimeListCompleted;
    this.userAnimeListDropped = userAnimeListDropped;
    this.userAnimeListPaused = userAnimeListPaused;

    userAnimeListAll = [
      ...userAnimeListCurrent,
      ...userAnimeListPlanning,
      ...userAnimeListCompleted,
      ...userAnimeListDropped,
      ...userAnimeListPaused,
    ];
  }

  void setUserMangaLists(
    List<UserMangaResult> userMangaListCurrent,
    List<UserMangaResult> userMangaListPlanning,
    List<UserMangaResult> userMangaListCompleted,
    List<UserMangaResult> userMangaListDropped,
  ) {
    this.userMangaListCurrent = userMangaListCurrent;
    this.userMangaListPlanning = userMangaListPlanning;
    this.userMangaListCompleted = userMangaListCompleted;
    this.userMangaListDropped = userMangaListDropped;
  }
}