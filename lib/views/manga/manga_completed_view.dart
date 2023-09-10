import 'package:arcanus_reborn/widgets/manga/user_manga_card.dart';
import 'package:flutter/material.dart';

class MangaCompletedView extends StatelessWidget {
  const MangaCompletedView({super.key, required this.userMangaListCompleted});

  final List<dynamic> userMangaListCompleted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userMangaListCompleted.length,
      itemBuilder: (context, index) {
        return UserMangaCard(mangaResult: userMangaListCompleted[index]);
      },
    );
  }
}