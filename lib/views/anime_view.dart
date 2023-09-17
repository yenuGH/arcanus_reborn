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
    BlocProvider.of<MediaViewBloc>(context).add(MediaViewInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    List<MediaListResult> animeList;
    animeList = AnilistClient().getUserAnimeList(widget.mediaListStatus);

    return ListView.builder(
      itemCount: animeList.length,
      itemBuilder: (context, index) {
        return MediaListCard(mediaResult: animeList[index]);
      },
    );
  }
}
