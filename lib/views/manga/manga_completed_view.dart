import 'package:flutter/material.dart';

class MangaCompletedView extends StatelessWidget {
  const MangaCompletedView({super.key});

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
              title: Text("Manga completed$index"),
              subtitle: Text("Chapter $index"),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
        );
      },
    );
  }
}