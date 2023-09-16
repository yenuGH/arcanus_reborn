// ignore_for_file: unused_import

import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/pages/media_info_page.dart';
import 'package:flutter/material.dart';

class MediaResultCard extends StatefulWidget {
  const MediaResultCard({super.key, required this.mediaResult});

  final dynamic mediaResult;

  @override
  State<MediaResultCard> createState() => _MediaResultCardState(

  );
}

class _MediaResultCardState extends State<MediaResultCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.pushNamed(
            context, 
            "/media_info_page",
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
          height: 150,

          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                width: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    widget.mediaResult.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
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
                      episodeCounter(),

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          status(),
                          const Spacer(),
                          Text(
                            widget.mediaResult.averageScore.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
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

  Text episodeCounter() {
    if (widget.mediaResult.status == "RELEASING"){
      return const Text(
        "Ongoing..."
      );
    }
    else if (widget.mediaResult.status == "UNRELEASED"){
      return const Text(
        "Unreleased..."
      );
    }
    else if (widget.mediaResult.status == "FINISHED"){
      switch(widget.mediaResult.mediaType){
        case (MediaType.ANIME): {
          if (widget.mediaResult.episodes == 1){
            return const Text(
              "1 episode"
            );
          }
          else {
            return Text(
              "${widget.mediaResult.episodes} episodes"
            );
          }
        }
        case (MediaType.MANGA): {
          if (widget.mediaResult.chapters == 1){
            return const Text(
              "1 chapter"
            );
          }
          else {
            return Text(
              "${widget.mediaResult.chapters} chapters"
            );
          }
        }
        default: {
          return const Text(
            "Error..."
          );
        }
      }
    }
    else if (widget.mediaResult.status == "CANCELLED"){
      return const Text(
        "Cancelled..."
      );
    }
    else if (widget.mediaResult.status == "HIATUS"){
      return const Text(
        "Hiatus..."
      );
    }

    return const Text(
      "Error..."
    );
  }
}