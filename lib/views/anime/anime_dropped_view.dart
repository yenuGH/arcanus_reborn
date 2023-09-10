import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:arcanus_reborn/widgets/anime/user_anime_card.dart';
import 'package:flutter/material.dart';

class AnimeDroppedView extends StatelessWidget {
  const AnimeDroppedView({super.key, required this.userAnimeListDropped});

  final List<AnimeResult> userAnimeListDropped;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userAnimeListDropped.length,
      itemBuilder: (context, index) {
        return UserAnimeCard(animeResult: userAnimeListDropped[index]);
      },
    );
  }
}