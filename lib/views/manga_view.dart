import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/controllers/blocs/media_view/media_view_bloc.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/media_list_result.dart';
import 'package:arcanus_reborn/widgets/media_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MangaView extends StatelessWidget {
  const MangaView({super.key, required this.mediaListStatus});

  final MediaListStatus mediaListStatus;

  @override
  Widget build(BuildContext context) {
    List<MediaListResult> mangaList;
    mangaList = AnilistClient().getUserMangaList(mediaListStatus);

    return BlocBuilder<MediaViewBloc, MediaViewState>(
      builder: (_, state) {
        return ListView.builder(
          itemCount: mangaList.length,
          itemBuilder: (context, index) {
            return MediaListCard(mediaResult: mangaList[index]);
          },
        );
      },
    );
  }
}
