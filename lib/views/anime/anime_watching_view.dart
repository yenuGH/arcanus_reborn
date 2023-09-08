import 'package:flutter/material.dart';

class AnimeWatchingView extends StatelessWidget {
  const AnimeWatchingView({super.key, required this.homePageContext});

  final BuildContext homePageContext;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.image),
            title: Text("Anime $index"),
            subtitle: Text("Episode $index"),
            trailing: const Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}