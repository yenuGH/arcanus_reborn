import 'package:arcanus_reborn/controllers/cubits/filter_bar/anime/filter_bar_anime_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AnimeFilterBar extends StatefulWidget {
  const AnimeFilterBar({super.key});
  @override
  State<AnimeFilterBar> createState() => _AnimeFilterBarState();
}

class _AnimeFilterBarState extends State<AnimeFilterBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color(0xff00C7FF),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.play_arrow),
          label: 'Watching',
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
          icon: Icon(Icons.pause),
          label: 'Paused',
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
              BlocProvider.of<FilterBarAnimeCubit>(context).watchingTab();
              break;
            }
          case 1:
            {
              BlocProvider.of<FilterBarAnimeCubit>(context).planningTab();
              break;
            }
          case 2:
            {
              BlocProvider.of<FilterBarAnimeCubit>(context).completedTab();
              break;
            }
          case 3:
            {
              BlocProvider.of<FilterBarAnimeCubit>(context).pausedTab();
              break;
            }
          case 4:
            {
              BlocProvider.of<FilterBarAnimeCubit>(context).droppedTab();
              break;
            }
          default:
            {
              BlocProvider.of<FilterBarAnimeCubit>(context).watchingTab();
              break;
            }
        }
      },
    );
  }
}