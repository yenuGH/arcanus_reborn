import 'package:flutter/material.dart';

class AnimeWatchingView extends StatelessWidget {
  const AnimeWatchingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              
            },
            child: ListTile(
              leading: const Icon(Icons.image),
              title: Text("Anime $index"),
              subtitle: Text("Episode $index"),
            ),
          ),
        );
      },
    );
  }
}