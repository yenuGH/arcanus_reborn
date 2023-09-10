import 'package:arcanus_reborn/pages/manga/manga_edit_page.dart';
import 'package:flutter/material.dart';

class UserMangaCard extends StatefulWidget {
  const UserMangaCard({super.key, required this.mangaResult});

  final dynamic mangaResult;

  @override
  State<UserMangaCard> createState() => _UserMangaCardState();
}

class _UserMangaCardState extends State<UserMangaCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => MangaEditPage(mangaResult: widget.mangaResult)
            )
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
                    widget.mangaResult.coverImage,
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

                      Text(
                        widget.mangaResult.status,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
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

  Text mangaCounter() {
    String mangaCount = widget.mangaResult.chapters == 0 ? "?" : widget.mangaResult.chapters.toString();

    return Text(
      '${widget.mangaResult.progress}/$mangaCount',
      style: const TextStyle(
        fontSize: 15,
      ),
    );
  }
}