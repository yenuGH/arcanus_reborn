import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:arcanus_reborn/widgets/anime/user_anime_card.dart';
import 'package:flutter/material.dart';

class AnimeWatchingView extends StatelessWidget {
  const AnimeWatchingView({super.key, required this.userAnimeListCurrent});

  final List<AnimeResult> userAnimeListCurrent;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userAnimeListCurrent.length,
      itemBuilder: (context, index) {
        return UserAnimeCard(animeResult: userAnimeListCurrent[index]);
      },
    );
  }
}