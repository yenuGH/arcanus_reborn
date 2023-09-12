import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/pages/media_entry_page.dart.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:html/parser.dart';

class MediaInfoPage extends StatefulWidget {
  const MediaInfoPage({super.key, required this.mediaResult});

  final dynamic mediaResult;

  @override
  State<MediaInfoPage> createState() => _MediaInfoPageState();
}

class _MediaInfoPageState extends State<MediaInfoPage> {
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
                  builder: (context) => MediaEntryPage(mediaResult: widget.mediaResult)
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
              mediaHeader(),

              createSpacing(),

              mediaGenres(),

              createSpacing(),

              mediaDescription(),

              createSpacing(),

              mediaStatus(),

              createSpacing(),

              widget.mediaResult.mediaType == MediaType.ANIME ? mediaEpisodes() : mediaChapters(),

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
          widget.mediaResult.coverImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget mediaAverageScore () {
    return Row(
      children: <Widget>[
        const Icon(Icons.star_border),

        Container(
          width: 10,
        ),

        Text(
          widget.mediaResult.averageScore.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget mediaAverageScoreRatingBar () {
    return RatingBar(
      initialRating: widget.mediaResult.averageScore.toDouble() / 20,
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

  Widget mediaTitleUserPreferred() {
    return Text(
      widget.mediaResult.titleUserPreferred,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget mediaTitleAlternatives(String alternativeTitle) {
    return Text(
      "\u2022 $alternativeTitle",
      style: const TextStyle(
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget mediaStatus() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Status: ${widget.mediaResult.status}",
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget mediaHeader() {
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
                mediaTitleUserPreferred(),
                Container(
                  height: 5,
                ),
                mediaAverageScoreRatingBar(),
                createSpacing(),
                const Text("Alternative titles: "),
                mediaTitleAlternatives(widget.mediaResult.titleEnglish),
                mediaTitleAlternatives(widget.mediaResult.titleRomaji),
                mediaTitleAlternatives(widget.mediaResult.titleNative),
              ],
            ),
          ),
        ]
      ),
    );
  }

  Widget mediaDescription() {
    var htmlString = parse(widget.mediaResult.description);
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

  Widget mediaGenres() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemCount: widget.mediaResult.genres.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Chip(
            label: Text(widget.mediaResult.genres[index]),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget mediaEpisodes() {
    late String episodesString;
    if (widget.mediaResult.status == "FINISHED"){
      episodesString = "Episodes: ${widget.mediaResult.episodes}";
    }
    if (widget.mediaResult.status == "RELEASING"){
      episodesString = "Next episode: ${widget.mediaResult.nextAiringEpisode['episode']}";
    }
    if (widget.mediaResult.status == "UNRELEASED"){
      episodesString = "Episodes: Unknown";
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

  Widget mediaChapters() {
    late String chaptersString;
    if (widget.mediaResult.status == "FINISHED"){
      chaptersString = "Chapters: ${widget.mediaResult.chapters}";
    }
    else {
      chaptersString = "Chapters: Unknown";
    }

    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        chaptersString,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
