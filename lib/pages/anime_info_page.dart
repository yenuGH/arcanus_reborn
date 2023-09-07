import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

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
        title: Text("Information"),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              animeHeader(),

              createSpacing(),

              animeGenres(),

              createSpacing(),

              animeDescription(),

              createSpacing(),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Status: " + widget.animeResult.status,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

              createSpacing(),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Episodes: " + widget.animeResult.episodes.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

              createSpacing(),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Average Score: " + widget.animeResult.averageScore.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget createSpacing() {
    return Container(
      padding: const EdgeInsets.all(10),
    );
  }

  Widget coverImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 250,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Image.network(
          widget.animeResult.coverImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget animeTitleUserPreferred() {
    return Text(
      widget.animeResult.titleUserPreferred,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget animeTitleAlternatives() {
    return Text(
      "\u2022 ${widget.animeResult.titleEnglish}, ${widget.animeResult.titleRomaji}, ${widget.animeResult.titleNative}",
      style: const TextStyle(
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget animeHeader() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          coverImage(),
    
          createSpacing(),
    
          Container(
            width: 200,
            height: 250,
            child: ListView(
              children: <Widget>[
                animeTitleUserPreferred(),
                createSpacing(),
                animeTitleAlternatives(),
              ],
            ),
          ),
        ]
      ),
    );
  }

  Widget animeDescription() {
    var htmlString = parse(widget.animeResult.description);
    var parsedString = parse(htmlString.body!.text).documentElement!.text;

    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        parsedString,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget animeGenres() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemCount: widget.animeResult.genres.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Chip(
            label: Text(widget.animeResult.genres[index]),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
