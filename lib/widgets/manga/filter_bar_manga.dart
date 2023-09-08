import 'package:arcanus_reborn/controllers/cubits/filter_bar/manga/filter_bar_manga_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MangaFilterBar extends StatefulWidget {
  const MangaFilterBar({super.key});

  @override
  State<MangaFilterBar> createState() => _MangaFilterBarState();
}

class _MangaFilterBarState extends State<MangaFilterBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color(0xff00C7FF),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories),
          label: 'Reading',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_play),
          label: 'Planning',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done_all),
          label: 'Completed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.do_not_disturb_on_total_silence),
          label: 'Dropped',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });

        switch (value) {
          case 0:
            {
              BlocProvider.of<FilterBarMangaCubit>(context).readingTab();
              break;
            }
          case 1:
            {
              BlocProvider.of<FilterBarMangaCubit>(context).planningTab();
              break;
            }
          case 2:
            {
              BlocProvider.of<FilterBarMangaCubit>(context).completedTab();
              break;
            }
          case 3:
            {
              BlocProvider.of<FilterBarMangaCubit>(context).droppedTab();
              break;
            }
          default:
            {
              BlocProvider.of<FilterBarMangaCubit>(context).readingTab();
              break;
            }
        }
      },
    );
  }
}