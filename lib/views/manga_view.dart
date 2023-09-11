import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
import 'package:arcanus_reborn/models/user_manga_result.dart';
import 'package:arcanus_reborn/widgets/manga/user_manga_card.dart';
import 'package:flutter/material.dart';

class MangaView extends StatelessWidget {
  const MangaView({super.key, required this.mediaListStatus});

  final MediaListStatus mediaListStatus;

  @override
  Widget build(BuildContext context) {
    List<MediaListResult> mangaList;
    switch (mediaListStatus) {
      case (MediaListStatus.CURRENT):
      {
        mangaList = AnilistClient().userMangaListCurrent!;
        break;
      }
      case (MediaListStatus.PLANNING):
      {
        mangaList = AnilistClient().userMangaListPlanning!;
        break;
      }
      case (MediaListStatus.COMPLETED):
      {
        mangaList = AnilistClient().userMangaListCompleted!;
        break;
      }
      case (MediaListStatus.DROPPED):
      {
        mangaList = AnilistClient().userMangaListDropped!;
        break;
      }
      default:
      {
        mangaList = AnilistClient().userMangaListCurrent!;
      }
    }

    return ListView.builder(
      itemCount: mangaList.length,
      itemBuilder: (context, index) {
        return UserMangaCard(mangaResult: mangaList[index]);
      },
    );
  }
}