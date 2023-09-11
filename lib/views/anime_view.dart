import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/user_anime_result.dart';
import 'package:arcanus_reborn/widgets/anime/user_anime_card.dart';
import 'package:flutter/material.dart';

class AnimeView extends StatelessWidget {
  const AnimeView({super.key, required this.mediaListStatus});

  final MediaListStatus mediaListStatus;

  @override
  Widget build(BuildContext context) {
    List<UserAnimeResult> animeList = [];
    switch (mediaListStatus) {
      case (MediaListStatus.CURRENT):
      {
        animeList = AnilistClient().userAnimeListCurrent!;
        break;
      }
      default:
      {
        animeList = AnilistClient().userAnimeListCurrent!;
      }
    }

    return ListView.builder(
      itemCount: animeList.length,
      itemBuilder: (context, index) {
        return UserAnimeCard(animeResult: animeList[index]);
      },
    );
  }
}