import 'package:arcanus_reborn/pages/manga/manga_edit_page.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:html/parser.dart';

class MangaInfoPage extends StatefulWidget {
  const MangaInfoPage({super.key, required this.mangaResult});

  final dynamic mangaResult;

  @override
  State<MangaInfoPage> createState() => _MangaInfoPageState();
}

class _MangaInfoPageState extends State<MangaInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Information"),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => MangaEditPage(mangaResult: widget.mangaResult)
                )
              );
            },
          )
        ],
      ),

      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              mangaHeader(),

              createSpacing(),

              mangaGenres(),

              createSpacing(),

              mangaDescription(),

              createSpacing(),

              mangaStatus(),

              createSpacing(),

              mangaChapters(),

              createSpacing(),
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
          widget.mangaResult.coverImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget mangaAverageScore () {
    return Row(
      children: <Widget>[
        const Icon(Icons.star_border),

        Container(
          width: 10,
        ),

        Text(
          widget.mangaResult.averageScore.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget mangaAverageScoreRatingBar () {
    return RatingBar(
      initialRating: widget.mangaResult.averageScore.toDouble() / 20,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 20,
      ratingWidget: RatingWidget(
        full: const Icon(Icons.star),
        half: const Icon(Icons.star_half),
        empty: const Icon(Icons.star_border),
      ),
      glow: false,
      ignoreGestures: true,
      onRatingUpdate: (double value) {},
    );
  }

  Widget mangaTitleUserPreferred() {
    return Text(
      widget.mangaResult.titleUserPreferred,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget mangaTitleAlternatives(String alternativeTitle) {
    return Text(
      "\u2022 $alternativeTitle",
      style: const TextStyle(
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget mangaStatus() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Status: ${widget.mangaResult.status}",
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget mangaHeader() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          coverImage(),

          createSpacing(),
    
          SizedBox(
            width: 190,
            height: 250,
            child: ListView(
              children: <Widget>[
                mangaTitleUserPreferred(),
                Container(
                  height: 5,
                ),
                mangaAverageScoreRatingBar(),
                createSpacing(),
                const Text("Alternative titles: "),
                mangaTitleAlternatives(widget.mangaResult.titleEnglish),
                mangaTitleAlternatives(widget.mangaResult.titleRomaji),
                mangaTitleAlternatives(widget.mangaResult.titleNative),
              ],
            ),
          ),
        ]
      ),
    );
  }

  Widget mangaDescription() {
    var htmlString = parse(widget.mangaResult.description);
    var parsedString = parse(htmlString.body!.text).documentElement!.text;

    return ExpandableText(
      parsedString,
      expandText: "read more...",
      expandOnTextTap: true,
      collapseText: "read less...",
      collapseOnTextTap: true,
      animation: true,
      animationCurve: Curves.easeInOut,
      maxLines: 4,
    );
  }

  Widget mangaGenres() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemCount: widget.mangaResult.genres.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Chip(
            label: Text(widget.mangaResult.genres[index]),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget mangaChapters() {
    late String episodesString;
    if (widget.mangaResult.status == "FINISHED"){
      episodesString = "Chapters: ${widget.mangaResult.chapters}";
    }
    if (widget.mangaResult.status == "RELEASING"){
      episodesString = "Next chapter: ??";
    }
    if (widget.mangaResult.status == "UNRELEASED"){
      episodesString = "Chapter: Unknown";
    }

    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        episodesString,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

}