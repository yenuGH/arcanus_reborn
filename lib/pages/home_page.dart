import 'package:arcanus_reborn/controllers/cubits/filter_bar/anime/filter_bar_anime_cubit.dart';
import 'package:arcanus_reborn/controllers/cubits/filter_bar/manga/filter_bar_manga_cubit.dart';
import 'package:arcanus_reborn/controllers/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/views/anime/anime_completed_view.dart';
import 'package:arcanus_reborn/views/anime/anime_dropped_view.dart';
import 'package:arcanus_reborn/views/anime/anime_paused_view.dart';
import 'package:arcanus_reborn/views/anime/anime_planning_view.dart';
import 'package:arcanus_reborn/views/anime/anime_watching_view.dart';
import 'package:arcanus_reborn/views/manga/manga_completed_view.dart';
import 'package:arcanus_reborn/views/manga/manga_dropped_view.dart';
import 'package:arcanus_reborn/views/manga/manga_planning_view.dart';
import 'package:arcanus_reborn/views/manga/manga_reading_view.dart';
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
  void initState () {
    super.initState();
    BlocProvider.of<TabBarCubit>(context).animeTab();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, TabBarState>(
      builder: (_, state) {
        return DefaultTabController(
          length: widget._tabCount,
          child: WillPopScope(
            onWillPop: () async => false, // Disable back button
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                bottom: const MediaTypeTabBar(),
              ),
              drawer: const AppDrawer(),
          
              body: BlocBuilder<TabBarCubit, TabBarState>(
                builder: (_, tabBarState) {
                  return BlocBuilder<FilterBarAnimeCubit, FilterBarAnimeState>(
                    builder: (_, filterBarAnimeState) {
                      return BlocBuilder<FilterBarMangaCubit, FilterBarMangaState>(
                        builder: (_, filterBarMangaState) {
                          Widget selectedView;
          
                          switch (tabBarState.runtimeType) {
                            case TabBarAnime:
                              {
                                switch (filterBarAnimeState.runtimeType) {
                                  case FilterBarAnimeWatching:
                                    selectedView = AnimeWatchingView(userAnimeListCurrent: AnilistClient().userAnimeListCurrent!);
                                    break;
                                  case FilterBarAnimePlanning:
                                    selectedView = AnimePlanningView(userAnimeListPlanning: AnilistClient().userAnimeListPlanning!);
                                    break;
                                  case FilterBarAnimeCompleted:
                                    selectedView = AnimeCompletedView(userAnimeListCompleted: AnilistClient().userAnimeListCompleted!);
                                    break;
                                  case FilterBarAnimePaused:
                                    selectedView = AnimePausedView(userAnimeListPaused: AnilistClient().userAnimeListPaused!);
                                     break;
                                  case FilterBarAnimeDropped:
                                    selectedView = AnimeDroppedView(userAnimeListDropped: AnilistClient().userAnimeListDropped!);
                                    break;
                                  default:
                                    selectedView = AnimeWatchingView(userAnimeListCurrent: AnilistClient().userAnimeListCurrent!);
                                    break;
                                }
                              }
                              break;
                            case TabBarManga:
                              {
                                switch (filterBarMangaState.runtimeType) {
                                  case FilterBarMangaReading:
                                    selectedView = MangaReadingView(userMangaListCurrent: AnilistClient().userMangaListCurrent!);
                                    break;
                                  case FilterBarMangaPlanning:
                                    selectedView = MangaPlanningView(userMangaListPlanning: AnilistClient().userMangaListPlanning!);
                                    break;
                                  case FilterBarMangaCompleted:
                                    selectedView = MangaCompletedView(userMangaListCompleted: AnilistClient().userMangaListCompleted!);
                                    break;
                                  case FilterBarMangaDropped:
                                    selectedView = MangaDroppedView(userMangaListDropped: AnilistClient().userMangaListDropped!);
                                    break;
                                  default:
                                    selectedView = MangaReadingView(userMangaListCurrent: AnilistClient().userMangaListCurrent!);
                                    break;
                                }
                              }
                              break;
                            default:
                              selectedView = AnimeWatchingView(userAnimeListCurrent: AnilistClient().userMangaListCurrent!);
                              break;
                          }
          
                          return selectedView;
                        },
                      );
                    },
                  );
                },
              ),
          
          
              // the bottom navigation bar will change depending on a cubit
              bottomNavigationBar: BlocBuilder<TabBarCubit, TabBarState>(
                builder: (_, state) {
                  if (state == TabBarAnime()) {
                    return const AnimeFilterBar();
                  } 
                  else if (state == TabBarManga()) {
                    return const MangaFilterBar();
                  } 
                  else {
                    return const AnimeFilterBar();
                    // if either one fails, default to anime as it is default media type
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
