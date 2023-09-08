import 'package:flutter/material.dart';

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
      },
    );
  }
}