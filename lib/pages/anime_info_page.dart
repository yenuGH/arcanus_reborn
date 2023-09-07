import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:arcanus_reborn/pages/anime_edit_page.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                  builder: (context) => AnimeEditPage(animeResult: widget.animeResult)
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
              animeHeader(),

              createSpacing(),

              animeGenres(),

              createSpacing(),

              animeDescription(),

              createSpacing(),

              animeStatus(),

              createSpacing(),

              animeEpisodes(),

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
          widget.animeResult.coverImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget animeAverageScore () {
    return Row(
      children: <Widget>[
        const Icon(Icons.star_border),

        Container(
          width: 10,
        ),

        Text(
          widget.animeResult.averageScore.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget animeAverageScoreRatingBar () {
    return RatingBar(
      initialRating: widget.animeResult.averageScore.toDouble() / 10,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 10,
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

  Widget animeTitleUserPreferred() {
    return Text(
      widget.animeResult.titleUserPreferred,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget animeTitleAlternatives(String alternativeTitle) {
    return Text(
      "\u2022 $alternativeTitle",
      style: const TextStyle(
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget animeStatus() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Status: ${widget.animeResult.status}",
        style: const TextStyle(
          fontSize: 15,
        ),
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
    
          SizedBox(
            width: 200,
            height: 250,
            child: ListView(
              children: <Widget>[
                animeTitleUserPreferred(),
                Container(
                  height: 5,
                ),
                animeAverageScoreRatingBar(),
                createSpacing(),
                const Text("Alternative titles: "),
                animeTitleAlternatives(widget.animeResult.titleEnglish),
                animeTitleAlternatives(widget.animeResult.titleRomaji),
                animeTitleAlternatives(widget.animeResult.titleNative),
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

  Widget animeEpisodes() {
    late String episodesString;
    if (widget.animeResult.status == "FINISHED"){
      episodesString = "Episodes: ${widget.animeResult.episodes}";
    }
    if (widget.animeResult.status == "RELEASING"){
      episodesString = "Next episode: ${widget.animeResult.nextAiringEpisode['episode']}";
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
