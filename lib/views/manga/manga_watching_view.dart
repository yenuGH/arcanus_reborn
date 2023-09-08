import 'package:flutter/material.dart';

class MangaWatchingView extends StatelessWidget {
  const MangaWatchingView({super.key, required this.homePageContext});

  final BuildContext homePageContext;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.image),
            title: Text("Manga $index"),
            subtitle: Text("Chapter $index"),
            trailing: const Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}