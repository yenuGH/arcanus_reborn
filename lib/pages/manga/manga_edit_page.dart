
import 'package:flutter/material.dart';

class MangaEditPage extends StatefulWidget {
  const MangaEditPage({super.key, required this.mangaResult});

  final dynamic mangaResult;

  @override
  State<MangaEditPage> createState() => _MangaEditPageState();
}

class _MangaEditPageState extends State<MangaEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: Text("edit page for ${widget.mangaResult.titleUserPreferred}"),
    );
  }
}