import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/controllers/blocs/media_view/media_view_bloc.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
import 'package:arcanus_reborn/widgets/media_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeView extends StatelessWidget {
  const AnimeView({super.key, required this.mediaListStatus});

  final MediaListStatus mediaListStatus;

  @override
  Widget build(BuildContext context) {
    List<MediaListResult> animeList;
    switch (mediaListStatus) {
      case (MediaListStatus.CURRENT):
        {
          animeList = AnilistClient().userAnimeListCurrent!;
          break;
        }
      case (MediaListStatus.PLANNING):
        {
          animeList = AnilistClient().userAnimeListPlanning!;
          break;
        }
      case (MediaListStatus.COMPLETED):
        {
          animeList = AnilistClient().userAnimeListCompleted!;
          break;
        }
      case (MediaListStatus.DROPPED):
        {
          animeList = AnilistClient().userAnimeListDropped!;
          break;
        }
      case (MediaListStatus.PAUSED):
        {
          animeList = AnilistClient().userAnimeListPaused!;
          break;
        }
      default:
        {
          animeList = AnilistClient().userAnimeListCurrent!;
        }
    }

    return BlocBuilder<MediaViewBloc, MediaViewState>(
      builder: (_, state) {
        switch (state.runtimeType){
          default: {
            return ListView.builder(
              itemCount: animeList.length,
              itemBuilder: (context, index) {
                return MediaListCard(mediaResult: animeList[index]);
              },
            );
          }
        }
      },
    );
  }
}
