import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:arcanus_reborn/widgets/anime/user_anime_card.dart';
import 'package:flutter/material.dart';

class AnimePlanningView extends StatelessWidget {
  const AnimePlanningView({super.key, required this.userAnimeListPlanning});

  final List<AnimeResult> userAnimeListPlanning;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userAnimeListPlanning.length,
      itemBuilder: (context, index) {
        return UserAnimeCard(animeResult: userAnimeListPlanning[index]);
      },
    );
  }
}