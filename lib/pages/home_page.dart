import 'package:arcanus_reborn/constants/enums.dart';
import 'package:arcanus_reborn/controllers/blocs/user_media/user_media_bloc.dart';
import 'package:arcanus_reborn/controllers/cubits/filter_bar/anime/filter_bar_anime_cubit.dart';
import 'package:arcanus_reborn/controllers/cubits/filter_bar/manga/filter_bar_manga_cubit.dart';
import 'package:arcanus_reborn/controllers/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:arcanus_reborn/views/anime_view.dart';
import 'package:arcanus_reborn/views/manga_view.dart';
import 'package:arcanus_reborn/widgets/app_drawer.dart';
import 'package:arcanus_reborn/widgets/filter_bar_anime.dart';
import 'package:arcanus_reborn/widgets/filter_bar_manga.dart';
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
                                    selectedView = const AnimeView(mediaListStatus: MediaListStatus.CURRENT);
                                    break;
                                  case FilterBarAnimePlanning:
                                    selectedView = const AnimeView(mediaListStatus: MediaListStatus.PLANNING);
                                    break;
                                  case FilterBarAnimeCompleted:
                                    selectedView = const AnimeView(mediaListStatus: MediaListStatus.COMPLETED);
                                    break;
                                  case FilterBarAnimePaused:
                                    selectedView = const AnimeView(mediaListStatus: MediaListStatus.PAUSED);
                                    break;
                                  case FilterBarAnimeDropped:
                                    selectedView = const AnimeView(mediaListStatus: MediaListStatus.DROPPED);
                                    break;
                                  default:
                                    selectedView = const AnimeView(mediaListStatus: MediaListStatus.CURRENT);
                                    break;
                                }
                              }
                              break;
                            case TabBarManga:
                              {
                                switch (filterBarMangaState.runtimeType) {
                                  case FilterBarMangaReading:
                                    selectedView = const MangaView(mediaListStatus: MediaListStatus.CURRENT);
                                    break;
                                  case FilterBarMangaPlanning:
                                    selectedView = const MangaView(mediaListStatus: MediaListStatus.PLANNING);
                                    break;
                                  case FilterBarMangaCompleted:
                                    selectedView = const MangaView(mediaListStatus: MediaListStatus.COMPLETED);
                                    break;
                                  case FilterBarMangaDropped:
                                    selectedView = const MangaView(mediaListStatus: MediaListStatus.DROPPED);
                                    break;
                                  default:
                                    selectedView = const MangaView(mediaListStatus: MediaListStatus.CURRENT);
                                    break;
                                }
                              }
                              break;
                            case TabBarReload: {
                              selectedView = const AnimeView(mediaListStatus: MediaListStatus.CURRENT);
                            }
                            default:
                              selectedView = const AnimeView(mediaListStatus: MediaListStatus.CURRENT);
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
