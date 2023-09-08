import 'package:arcanus_reborn/controllers/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:arcanus_reborn/views/anime/anime_watching_view.dart';
import 'package:arcanus_reborn/widgets/app_drawer.dart';
import 'package:arcanus_reborn/widgets/anime/filter_bar_anime.dart';
import 'package:arcanus_reborn/widgets/manga/filter_bar_manga.dart';
import 'package:arcanus_reborn/widgets/media_type_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => TabBarCubit(),
      child: DefaultTabController(
        length: widget._tabCount,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: const MediaTypeTabBar(),
          ),
          drawer: const AppDrawer(),

          body: BlocBuilder<TabBarCubit, TabBarState>(
            builder: (_, state) {
              if (state == TabBarAnime()) {
                return AnimeWatchingView(homePageContext: context);
              } else if (state == TabBarManga()) {
                return const Center(
                  child: Text("Manga"),
                );
              } else {
                return const Center(
                  child: Text("Anime"),
                );
                // if either one fails, default to anime as it is default media type
              }
            }
          ),

          // the bottom navigation bar will change depending on a cubit
          bottomNavigationBar: BlocBuilder<TabBarCubit, TabBarState>(
            builder: (context, state) {
              if (state == TabBarAnime()) {
                return const AnimeFilterBar();
              } else if (state == TabBarManga()) {
                return const MangaFilterBar();
              } else {
                return const AnimeFilterBar();
                // if either one fails, default to anime as it is default media type
              }
            },
          ),
        ),
      ),
    );
  }
}

class Something extends StatelessWidget {
  const Something({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Anime"),
    );
  }
}
