import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/pages/media_entry_page.dart.dart';
import 'package:flutter/material.dart';

class MediaListCard extends StatefulWidget {
  const MediaListCard({super.key, required this.mediaResult});

  final dynamic mediaResult;

  @override
  State<MediaListCard> createState() => _MediaListCardState();
}

class _MediaListCardState extends State<MediaListCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.pushNamed(
            context, 
            "/media_entry_page",
            arguments: {
              "mediaResult": widget.mediaResult,
            }
          );
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 125,

          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),

              // cover image
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                height: 120,
                width: 80,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    widget.mediaResult.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // text
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.mediaResult.titleUserPreferred,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),

                      progressCounter(),

                      const Spacer(),

                      status(),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Text progressCounter() {
    String episodeCount = widget.mediaResult.episodes == 0 ? "?" : widget.mediaResult.episodes.toString();
    String episodeProgress = "${widget.mediaResult.progress}/$episodeCount";

    String chapterCount = widget.mediaResult.chapters == 0 ? "?" : widget.mediaResult.chapters.toString();
    String chapterProgress = "${widget.mediaResult.progress}/$chapterCount";

    return Text(
      widget.mediaResult.mediaType == MediaType.ANIME ? episodeProgress : chapterProgress,
      style: const TextStyle(
        fontSize: 15,
      ),
    );
  }

  Text status() {
    if (widget.mediaResult.status == "RELEASING"){
      return const Text(
        "RELEASING",
        style: TextStyle(
          color: Colors.green,
        ),
      );
    }
    else if (widget.mediaResult.status == "UNRELEASED"){
      return const Text(
        "UNRELEASED",
        style: TextStyle(
          color: Colors.blueGrey,
        ),
      );
    }
    else if (widget.mediaResult.status == "FINISHED"){
      return const Text(
        "FINISHED",
        style: TextStyle(
          color: Colors.blue,
        ),
      );
    }
    else if (widget.mediaResult.status == "CANCELLED"){
      return const Text(
        "CANCELLED",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
    }
    else if (widget.mediaResult.status == "HIATUS"){
      return const Text(
        "HIATUS",
        style: TextStyle(
          color: Colors.orange,
        ),
      );
    }

    return const Text(
      "Error...",
        style: TextStyle(
          color: Colors.red,
        ),
    );
  }

}