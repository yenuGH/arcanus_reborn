import 'package:flutter/material.dart';

class AnimeCompletedView extends StatelessWidget {
  const AnimeCompletedView({super.key});

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
              title: Text("Anime Completed$index"),
              subtitle: Text("Episode $index"),
            ),
          ),
        );
      },
    );
  }
}