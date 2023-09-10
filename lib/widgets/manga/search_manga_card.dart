import 'package:arcanus_reborn/pages/manga/manga_info_page.dart';
import 'package:flutter/material.dart';

class SeachMangaCard extends StatefulWidget {
  const SeachMangaCard({super.key, required this.mangaResult});

  final dynamic mangaResult;

  @override
  State<SeachMangaCard> createState() => _SearchMangaCardState(

  );
}

class _SearchMangaCardState extends State<SeachMangaCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => MangaInfoPage(mangaResult: widget.mangaResult)
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
                    widget.mangaResult.coverImage,
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
                        widget.mangaResult.titleUserPreferred,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      mangaCounter(),

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          status(),
                          const Spacer(),
                          Text(
                            widget.mangaResult.averageScore.toString(),
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
    if (widget.mangaResult.status == "RELEASING"){
      return const Text(
        "RELEASING",
        style: TextStyle(
          color: Colors.green,
        ),
      );
    }
    else if (widget.mangaResult.status == "UNRELEASED"){
      return const Text(
        "UNRELEASED",
        style: TextStyle(
          color: Colors.blueGrey,
        ),
      );
    }
    else if (widget.mangaResult.status == "FINISHED"){
      return const Text(
        "FINISHED",
        style: TextStyle(
          color: Colors.blue,
        ),
      );
    }
    else if (widget.mangaResult.status == "CANCELLED"){
      return const Text(
        "CANCELLED",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
    }
    else if (widget.mangaResult.status == "HIATUS"){
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

  Text mangaCounter() {
    if (widget.mangaResult.status == "RELEASING"){
      return const Text(
        "Ongoing..."
      );
    }
    else if (widget.mangaResult.status == "UNRELEASED"){
      return const Text(
        "Unreleased..."
      );
    }
    else if (widget.mangaResult.status == "FINISHED"){
      if (widget.mangaResult.chapters == 1){
        return const Text(
          "1 chapter"
        );
      }
      else {
        return Text(
          "${widget.mangaResult.chapters} episodes"
        );
      }
    }
    else if (widget.mangaResult.status == "CANCELLED"){
      return const Text(
        "Cancelled..."
      );
    }
    else if (widget.mangaResult.status == "HIATUS"){
      return const Text(
        "Hiatus..."
      );
    }

    return const Text(
      "Error..."
    );
  }
}