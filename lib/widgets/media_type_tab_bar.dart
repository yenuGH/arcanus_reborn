import 'package:flutter/material.dart';

class MediaTypeTabBar extends StatelessWidget implements PreferredSizeWidget{
  const MediaTypeTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(
          text: "Anime",
        ),
        Tab(
          text: "Manga",
        ),
      ],
      indicatorColor: Colors.white,
      unselectedLabelColor: Colors.white,
      labelColor: Colors.blue,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(40);
}
