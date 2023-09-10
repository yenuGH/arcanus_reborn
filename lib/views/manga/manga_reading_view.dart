import 'package:arcanus_reborn/widgets/manga/user_manga_card.dart';
import 'package:flutter/material.dart';

class MangaReadingView extends StatelessWidget {
  const MangaReadingView({super.key, required this.userMangaListCurrent});

  final List<dynamic> userMangaListCurrent;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userMangaListCurrent.length,
      itemBuilder: (context, index) {
        return UserMangaCard(mangaResult: userMangaListCurrent[index]);
      },
    );
  }
}