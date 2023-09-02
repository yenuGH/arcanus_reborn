import 'package:arcanus_reborn/controller/cubits/tab_bar/tab_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaTypeTabBar extends StatefulWidget implements PreferredSizeWidget{
  const MediaTypeTabBar({
    super.key,
  });

  @override
  State<MediaTypeTabBar> createState() => _MediaTypeTabBarState();
  
  
  @override
  Size get preferredSize => const Size.fromHeight(45);
}

class _MediaTypeTabBarState extends State<MediaTypeTabBar> {
  //late int _mediaTypeTabBarIndex;
  late TabController _mediaTypeTabBarController;
  
  @override
  void initState() {
    super.initState();
    //_mediaTypeTabBarIndex = 0;
    _mediaTypeTabBarController = TabController(
      length: 2,
      vsync: Scaffold.of(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: const [
        Tab(
          text: "Anime",
        ),
        Tab(
          text: "Manga",
        ),
      ],

      controller: _mediaTypeTabBarController,

      indicatorColor: Colors.white,
      unselectedLabelColor: Colors.white,
      labelColor: Colors.blue,

      onTap: (value) {
        if (value == 0) {
          BlocProvider.of<TabBarCubit>(context).animeTab();
        }
        if (value == 1) {
          BlocProvider.of<TabBarCubit>(context).mangaTab();
        }
      },
    );
  }
}
