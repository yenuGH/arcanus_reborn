import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/controllers/blocs/media_entry/media_entry_bloc.dart';
import 'package:arcanus_reborn/models/media_result.dart';
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
  late MediaResult mediaEntryResult;

  late double score;

  @override
  void initState() {
    super.initState();
    mediaEntryBloc.add(MediaEntryInitialEvent(widget.mediaResult));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MediaEntryBloc, MediaEntryState>(
      bloc: mediaEntryBloc,
      listener: (_, state) {
        if (state is MediaEntryLoadedState) {
          mediaEntryResult = state.mediaResult;

          if (mediaEntryResult.inUserLists == true) {
            score = mediaEntryResult.userScore!.toDouble();
          } else {
            score = 0;
          }
        }
      },
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
        body: BlocBuilder<MediaEntryBloc, MediaEntryState>(
          bloc: mediaEntryBloc,
          builder: (_, state) {
            switch (state.runtimeType) {
              case (MediaEntryLoadedState || MediaEntryIdleState || MediaEntryScoreUpdateState):
                {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            mediaHeader(),
                            createSpacing(),
                            scoreSlider(),
                            statusDropdownMenu(),
                            createSpacing(),
                            createSpacing(),
                            progressCounter(),
                          ]),
                    ),
                  );
                }
              case (MediaEntryErrorState):
                {
                  return const Center(
                    child: Text("Error, please restart the app."),
                  );
                }
              default:
                {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            }
          },
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
          mediaEntryResult.coverImage,
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
          mediaEntryResult.averageScore.toString(),
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
      initialRating: mediaEntryResult.averageScore.toDouble() / 20,
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
      mediaEntryResult.titleUserPreferred,
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
        "Status: ${mediaEntryResult.status}",
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
                  mediaTitleAlternatives(mediaEntryResult.titleEnglish),
                  mediaTitleAlternatives(mediaEntryResult.titleRomaji),
                  mediaTitleAlternatives(mediaEntryResult.titleNative),
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
      statusDropdownMenuItems
          .add(DropdownMenuEntry(value: statusValue, label: statusValue));
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
              initialSelection: mediaEntryResult.userStatus,
              dropdownMenuEntries: statusDropdownMenuItems,
              onSelected: (String? value) {
                setState(() {});
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
    String progress = mediaEntryResult.inUserLists
        ? mediaEntryResult.userProgress.toString()
        : 0.toString();
    String total;
    if (mediaEntryResult.mediaType == MediaType.ANIME) {
      total = mediaEntryResult.episodes == 0
          ? "?"
          : mediaEntryResult.episodes.toString();
    } else {
      total = mediaEntryResult.chapters == 0
          ? "?"
          : mediaEntryResult.chapters.toString();
    }

    String mediaProgressTitle = mediaEntryResult.mediaType == MediaType.ANIME
        ? "Episodes watched: "
        : "Chapters read: ";
    String mediaProgressCounter = mediaEntryResult.mediaType == MediaType.ANIME
        ? "$progress/$total"
        : "$progress/$total";

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
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    splashRadius: 500,
                    onPressed: () {
                      setState(() {});
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

  Widget scoreSlider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Rating"),
        const SizedBox(
          height: 5,
        ),
        BlocBuilder<MediaEntryBloc, MediaEntryState>(
          bloc: mediaEntryBloc,
          buildWhen: (previous, current) {
            return (previous == current);
          },
          builder: (context, state) {
            return Slider(
              value: score,
              max: 10,
              activeColor: Colors.white,
              divisions: 20,
              label: score.toString(),
              onChanged: (value) {
                score = value;
                mediaEntryBloc.add(MediaEntryScoreUpdateEvent());
              },
            );
          },
        ),
      ],
    );
  }
}
