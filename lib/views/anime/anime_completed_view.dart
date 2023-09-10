import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:arcanus_reborn/widgets/anime/user_anime_card.dart';
import 'package:flutter/material.dart';

class AnimeCompletedView extends StatelessWidget {
  const AnimeCompletedView({super.key, required this.userAnimeListCompleted});

  final List<AnimeResult> userAnimeListCompleted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userAnimeListCompleted.length,
      itemBuilder: (context, index) {
        return UserAnimeCard(animeResult: userAnimeListCompleted[index]);
      },
    );
  }
}