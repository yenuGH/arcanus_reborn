import 'package:arcanus_reborn/widgets/manga/user_manga_card.dart';
import 'package:flutter/material.dart';

class MangaPlanningView extends StatelessWidget {
  const MangaPlanningView({super.key, required this.userMangaListPlanning});

  final List<dynamic> userMangaListPlanning;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userMangaListPlanning.length,
      itemBuilder: (context, index) {
        return UserMangaCard(mangaResult: userMangaListPlanning[index]);
      },
    );
  }
}