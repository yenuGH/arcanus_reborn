import 'package:arcanus_reborn/widgets/manga/user_manga_card.dart';
import 'package:flutter/material.dart';

class MangaDroppedView extends StatelessWidget {
  const MangaDroppedView({super.key, required this.userMangaListDropped});

  final List<dynamic> userMangaListDropped;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userMangaListDropped.length,
      itemBuilder: (context, index) {
        return UserMangaCard(mangaResult: userMangaListDropped[index]);
      },
    );
  }
}