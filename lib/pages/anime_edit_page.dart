import 'package:arcanus_reborn/models/anime_result.dart';
import 'package:flutter/material.dart';

class AnimeEditPage extends StatefulWidget {
  const AnimeEditPage({super.key, required this.animeResult});

  final AnimeResult animeResult;

  @override
  State<AnimeEditPage> createState() => _AnimeEditPageState();
}

class _AnimeEditPageState extends State<AnimeEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Text("edit page for ${widget.animeResult.titleUserPreferred}"),
    );
  }
}