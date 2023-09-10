import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:arcanus_reborn/pages/anime/anime_edit_page.dart';
import 'package:flutter/material.dart';

class UserAnimeCard extends StatefulWidget {
  const UserAnimeCard({super.key, required this.animeResult});

  final AnimeResult animeResult;

  @override
  State<UserAnimeCard> createState() => _UserAnimeCardState();
}

class _UserAnimeCardState extends State<UserAnimeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => AnimeEditPage(animeResult: widget.animeResult)
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

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
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
}