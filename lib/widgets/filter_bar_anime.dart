import 'package:flutter/material.dart';

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
      },
    );
  }
}