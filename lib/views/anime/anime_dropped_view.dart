import 'package:flutter/material.dart';

class AnimeDroppedView extends StatelessWidget {
  const AnimeDroppedView({super.key});

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
              title: Text("Anime Dropped$index"),
              subtitle: Text("Episode $index"),
            ),
          ),
        );
      },
    );
  }
}