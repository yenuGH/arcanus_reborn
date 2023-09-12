import 'package:arcanus_reborn/controllers/blocs/media_entry/media_entry_bloc.dart';
import 'package:arcanus_reborn/pages/media_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MediaEntryPage extends StatefulWidget {
  const MediaEntryPage({super.key, required this.mediaResult});

  final dynamic mediaResult;

  @override
  State<MediaEntryPage> createState() => _MediaEntryPageState();
}

class _MediaEntryPageState extends State<MediaEntryPage> {
  final MediaEntryBloc mediaEntryBloc = MediaEntryBloc();

  @override
  void initState() {
    super.initState();
    mediaEntryBloc.add(MediaEntryInitialEvent(widget.mediaResult));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mediaEntryBloc,
      child: Scaffold(
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
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MediaInfoPage(mediaResult: widget.mediaResult)));
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
                  mediaHeader(),

                  createSpacing(),

                  createSpacing(),

                  statusDropdownMenu(),

                  createSpacing(),

                  progressCounter(),
                ]),
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

  Widget mediaAverageScore() {
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

  Widget mediaAverageScoreRatingBar() {
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
          children: <Widget>[
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
          ]),
    );
  }

  Widget statusDropdownMenu() {
    List<String> statusValues = [
      "CURRENT",
      "PLANNING",
      "COMPLETED",
      "DROPPED",
      "PAUSED"
    ];
    List<DropdownMenuEntry<String>> statusDropdownMenuItems = [];

    for (String statusValue in statusValues) {
      statusDropdownMenuItems.add(DropdownMenuEntry(value: statusValue, label: statusValue));
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
              initialSelection: widget.mediaResult.userStatus,
              dropdownMenuEntries: statusDropdownMenuItems,
              onSelected: (String? value) {
                setState(() {
                });
              },
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              )),
        ],
      ),
    );
  }

  BoxDecoration customBoxDecoration() {
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

  Widget progressCounter() {
    int progress = widget.mediaResult.inUserLists ? widget.mediaResult.progress : 0;
    String mediaProgressTitle = widget.mediaResult.mediaType == "ANIME"
        ? "Episodes watched: "
        : "Chapters read: ";
    String mediaProgressCounter = widget.mediaResult.mediaType == "ANIME"
        ? "$progress/${widget.mediaResult.episodes}"
        : "$progress/${widget.mediaResult.chapters}";

    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mediaProgressTitle),
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
                      mediaProgressCounter,
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
                        
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    splashRadius: 500,
                    onPressed: () {
                      setState(() {
                        
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
