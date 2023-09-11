
import 'package:arcanus_reborn/pages/anime/anime_info_page.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:html/parser.dart';

class AnimeEditPage extends StatefulWidget {
  const AnimeEditPage({super.key, required this.animeResult});

  final dynamic animeResult;

  @override
  State<AnimeEditPage> createState() => _AnimeEditPageState();
}

class _AnimeEditPageState extends State<AnimeEditPage> {
  final List<String> _statusItems = ["CURRENT", "PLANNING", "COMPLETED", "DROPPED", "PAUSED"];
  String? _dropdownValue;

  late int episodesWatched;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => AnimeInfoPage(animeResult: widget.animeResult)
                )
              );
            },
          ),
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

              createSpacing(),

              statusDropdownMenu(),
              
              createSpacing(),

              episodeCounter(),
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
      initialRating: widget.animeResult.averageScore.toDouble() / 20,
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
            width: 190,
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

  Widget statusDropdownMenu() {
    List<String> statusValues = ["CURRENT", "PLANNING", "COMPLETED", "DROPPED", "PAUSED"];
    List<DropdownMenuEntry<String>> statusDropdownMenuItems = [];

    for (String statusValue in statusValues){
      statusDropdownMenuItems.add(
        DropdownMenuEntry(value: statusValue, label: statusValue)
      );
    }

    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Status: "),

          const SizedBox(
            height: 5,
          ),

          DropdownMenu<String>(
            initialSelection: widget.animeResult.userStatus,
            dropdownMenuEntries: statusDropdownMenuItems,
            onSelected: (String? value) {
              setState(() {
                _dropdownValue = value;
              });
            },
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            )
          ),
        ],
      ),
    );
  }

  BoxDecoration customBoxDecoration () {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border(
        top: BorderSide(width: 1.0, color: Colors.white),
        left: BorderSide(width: 1.0, color: Colors.white),
        right: BorderSide(width: 1.0, color: Colors.white),
        bottom: BorderSide(width: 1.0, color: Colors.white),
      ),
    );
  }

  Widget episodeCounter() {
    episodesWatched = widget.animeResult.progress;

    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Episodes watched: " ),

              const SizedBox(
                height: 5,
              ),
              
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 60,
                    decoration: customBoxDecoration(), 
                    child: Text(
                      "$episodesWatched/${widget.animeResult.episodes}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  IconButton(
                    icon: const Icon(Icons.remove),
                    splashRadius: 500,
                    onPressed: () {
                      setState(() {
                        episodesWatched--;
                      });
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.add),
                    splashRadius: 500,
                    onPressed: () {
                      setState(() {
                        episodesWatched++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}