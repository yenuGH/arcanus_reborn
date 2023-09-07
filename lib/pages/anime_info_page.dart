import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:flutter/material.dart';

class AnimeInfoPage extends StatefulWidget {
  const AnimeInfoPage({super.key, required this.animeResult});

  final AnimeResult animeResult;

  @override
  State<AnimeInfoPage> createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animeResult.titleUserPreferred),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ),

      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    widget.animeResult.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.animeResult.titleUserPreferred,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.animeResult.description,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Status: " + widget.animeResult.status,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Episodes: " + widget.animeResult.episodes.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Average Score: " + widget.animeResult.averageScore.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Genres: " + widget.animeResult.genres.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
              ),
            ]
          ),
        ),
      ),
    );
  }
}