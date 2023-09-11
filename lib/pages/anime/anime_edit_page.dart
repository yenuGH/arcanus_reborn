
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

              statusDropdown(),
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

  Widget statusDropdown () {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Status: "),

          DropdownButton<String>(
            value: _dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(
              color: Colors.white
            ),
            underline: Container(
              height: 1,
              color: Colors.white,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _dropdownValue = newValue!;
              });
            },
            items: _statusItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
              }).toList(),
          ),
        ],
      ),
    );
  }
}