import 'dart:developer';

import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/controllers/blocs/media_view/media_view_bloc.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
import 'package:arcanus_reborn/widgets/media_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeView extends StatefulWidget {
  const AnimeView({super.key, required this.mediaListStatus});

  final MediaListStatus mediaListStatus;

  @override
  State<AnimeView> createState() => _AnimeViewState();
}

class _AnimeViewState extends State<AnimeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MediaListResult> animeList = AnilistClient().getUserAnimeList(widget.mediaListStatus);

    return BlocConsumer<MediaViewBloc, MediaViewState>(
      listener:(_, state) {
        switch (state.runtimeType) {
          case (MediaViewInitialState): {
            animeList = AnilistClient().getUserAnimeList(widget.mediaListStatus);
            break;
          }
          case (MediaViewReloadedState): {
            BlocProvider.of<MediaViewBloc>(context).add(MediaViewUpdateEvent());
            break;
          }
          default: {
            animeList = AnilistClient().getUserAnimeList(widget.mediaListStatus);
            break;
          }
        }  
      },
      builder: (_, state) {
        switch (state.runtimeType) {
          case (MediaViewReloadingState):
          {
            return const CircularProgressIndicator();
          }
          case (MediaViewInitialState || MediaViewUpdateState):
          {
            log("Building ${widget.mediaListStatus.name} list...");

            return ListView.builder(
              itemCount: animeList.length,
              itemBuilder: (context, index) {
                return MediaListCard(mediaResult: animeList[index]);
              },
            );
          }
          case (MediaViewErrorState): {
            return const Text("Error has occured, please restart the app.");
          }
          default:
          {
            return Container(
              alignment: Alignment.center,
              child: const Center(
                child: CircularProgressIndicator()
              )
            );
          }
        }
      },
    );
  }
}
