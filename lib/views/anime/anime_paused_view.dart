
import 'package:arcanus_reborn/widgets/anime/user_anime_card.dart';
import 'package:flutter/material.dart';

class AnimePausedView extends StatelessWidget {
  const AnimePausedView({super.key, required this.userAnimeListPaused});

  final List<dynamic> userAnimeListPaused;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userAnimeListPaused.length,
      itemBuilder: (context, index) {
        return UserAnimeCard(animeResult: userAnimeListPaused[index]);
      },
    );
  }
}