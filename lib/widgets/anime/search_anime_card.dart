import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:arcanus_reborn/pages/anime/anime_info_page.dart';
import 'package:flutter/material.dart';

class SearchAnimeCard extends StatefulWidget {
  const SearchAnimeCard({super.key, required this.animeResult});

  final AnimeResult animeResult;

  @override
  State<SearchAnimeCard> createState() => _SearchAnimeCardState(

  );
}

class _SearchAnimeCardState extends State<SearchAnimeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => AnimeInfoPage(animeResult: widget.animeResult)
            )
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
                    widget.animeResult.coverImage,
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
                        widget.animeResult.titleUserPreferred,
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
                            widget.animeResult.averageScore.toString(),
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
    if (widget.animeResult.status == "RELEASING"){
      return const Text(
        "RELEASING",
        style: TextStyle(
          color: Colors.green,
        ),
      );
    }
    else if (widget.animeResult.status == "UNRELEASED"){
      return const Text(
        "UNRELEASED",
        style: TextStyle(
          color: Colors.blueGrey,
        ),
      );
    }
    else if (widget.animeResult.status == "FINISHED"){
      return const Text(
        "FINISHED",
        style: TextStyle(
          color: Colors.blue,
        ),
      );
    }
    else if (widget.animeResult.status == "CANCELLED"){
      return const Text(
        "CANCELLED",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
    }
    else if (widget.animeResult.status == "HIATUS"){
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
    if (widget.animeResult.status == "RELEASING"){
      return const Text(
        "Ongoing..."
      );
    }
    else if (widget.animeResult.status == "UNRELEASED"){
      return const Text(
        "Unreleased..."
      );
    }
    else if (widget.animeResult.status == "FINISHED"){
      if (widget.animeResult.episodes == 1){
        return const Text(
          "1 episode"
        );
      }
      else {
        return Text(
          "${widget.animeResult.episodes} episodes"
        );
      }
    }
    else if (widget.animeResult.status == "CANCELLED"){
      return const Text(
        "Cancelled..."
      );
    }
    else if (widget.animeResult.status == "HIATUS"){
      return const Text(
        "Hiatus..."
      );
    }

    return const Text(
      "Error..."
    );
  }
}