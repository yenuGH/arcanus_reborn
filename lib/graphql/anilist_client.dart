// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/graphql/anilist_mutations.dart';
import 'package:arcanus_reborn/graphql/anilist_oauth.dart';
import 'package:arcanus_reborn/graphql/anilist_queries.dart';
import 'package:arcanus_reborn/models/anilist_user.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
import 'package:arcanus_reborn/models/media_result.dart';
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

  bool hasMutated = false;

  List<MediaListResult>? userAnimeListCurrent;
  List<MediaListResult>? userAnimeListPlanning;
  List<MediaListResult>? userAnimeListCompleted;
  List<MediaListResult>? userAnimeListDropped;
  List<MediaListResult>? userAnimeListPaused;
  List<MediaListResult>? userAnimeListAll;

  List<MediaListResult>? userMangaListCurrent;
  List<MediaListResult>? userMangaListPlanning;
  List<MediaListResult>? userMangaListCompleted;
  List<MediaListResult>? userMangaListDropped;

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

  Future<List<MediaListResult>> userMediaListQuery(MediaType mediaType, String status) async {

    QueryResult queryResult = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.userMediaListQuery),
        fetchPolicy: FetchPolicy.noCache,
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

    return mediaListResults;
  }

  Future<List<MediaResult>> mediaQuery(MediaType mediaType, String query) async {
    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.mediaQuery),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          'query': query,
          'type': mediaType.name,
        },
      ),
    );

    if (result.hasException) {
      // print("The exception is: " + result.exception.toString());
    }

    List<dynamic> resultData = result.data?['page']['media'];
    List<MediaResult> mediaResults = [];

    for (int i = 0; i < resultData.length; i++) {
      mediaResults.add(MediaResult.fromJson(resultData[i]));
    }

    return mediaResults;
  }

  Future<MediaResult> mediaEntryQuery(MediaType mediaType, int mediaId) async {
    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(AnilistQueries.mediaEntryQuery),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          'mediaId': mediaId,
          'type': mediaType.name,
        },
      ),
    );

    if (result.hasException) {
      log("The exception is: ${result.exception}");
    }
    
    Map<String, dynamic> resultData = result.data?['Media'];

    return MediaResult.fromJson(resultData);
  }

  Future<void> mediaEntryMutation(int mediaId, String status, int progress, double score, Map<String, dynamic> startedAt, Map<String, dynamic> completedAt) async {
    QueryResult result = await graphQLClient.mutate(
      MutationOptions(
        document: gql(AnilistMutations.mediaEntryMutation),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          'mediaId': mediaId,
          'status': MediaListStatus.values.byName(status).name,
          'progress': progress,
          'score': score,
          'startedAt': startedAt,
          'completedAt': completedAt,
        },
      ),
    );

    if (result.hasException) {
      log("The exception is: ${result.exception}");
    }

    hasMutated = true;

    return;
  }

  void setUserAnimeLists(
    List<MediaListResult> userAnimeListCurrent,
    List<MediaListResult> userAnimeListPlanning,
    List<MediaListResult> userAnimeListCompleted,
    List<MediaListResult> userAnimeListDropped,
    List<MediaListResult> userAnimeListPaused,
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
    List<MediaListResult> userMangaListCurrent,
    List<MediaListResult> userMangaListPlanning,
    List<MediaListResult> userMangaListCompleted,
    List<MediaListResult> userMangaListDropped,
  ) {
    this.userMangaListCurrent = userMangaListCurrent;
    this.userMangaListPlanning = userMangaListPlanning;
    this.userMangaListCompleted = userMangaListCompleted;
    this.userMangaListDropped = userMangaListDropped;
  }

  List<MediaListResult> getUserAnimeList(MediaListStatus mediaListStatus) {
    switch (mediaListStatus) {
      case (MediaListStatus.CURRENT):
        {
          return userAnimeListCurrent!;
        }
      case (MediaListStatus.PLANNING):
        {
          return userAnimeListPlanning!;
        }
      case (MediaListStatus.COMPLETED):
        {
          return userAnimeListCompleted!;
        }
      case (MediaListStatus.DROPPED):
        {
          return userAnimeListDropped!;
        }
      case (MediaListStatus.PAUSED):
        {
          return userAnimeListPaused!;
        }
      default:
        {
          return userAnimeListCurrent!;
        }
    }
  }

  List<MediaListResult> getUserMangaList(MediaListStatus mediaListStatus) {
    switch (mediaListStatus) {
      case (MediaListStatus.CURRENT):
        {
          return userMangaListCurrent!;
        }
      case (MediaListStatus.PLANNING):
        {
          return userMangaListPlanning!;
        }
      case (MediaListStatus.COMPLETED):
        {
          return userMangaListCompleted!;
        }
      case (MediaListStatus.DROPPED):
        {
          return userMangaListDropped!;
        }
      default:
        {
          return userMangaListCurrent!;
        }
    }
  }
}