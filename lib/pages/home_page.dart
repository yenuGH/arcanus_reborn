import 'package:arcanus_reborn/widgets/app_drawer.dart';
import 'package:arcanus_reborn/widgets/filter_bar_anime.dart';
import 'package:arcanus_reborn/widgets/media_type_tab_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  final int _tabCount = 2;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget._tabCount,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const MediaTypeTabBar(),
        ),
        drawer: const AppDrawer(),
        bottomNavigationBar: const AnimeFilterBar(),
      ),
    );
  }
}
