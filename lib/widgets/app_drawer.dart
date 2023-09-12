import 'package:arcanus_reborn/constants/search_type.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDrawer extends Drawer {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context){
    var anilistUserBox = Hive.box('anilistUser');

    return Drawer(
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(
                color: Colors.transparent,
              ),
            ),
            child: DrawerHeader(
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.darken,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.blueGrey.withOpacity(0.8)],
                ),
                image: DecorationImage(
                  image: NetworkImage(anilistUserBox.get("anilistUserBannerImage")),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(anilistUserBox.get("anilistUserAvatarLarge")),
                      radius: 48,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BorderedText(
                          strokeWidth: 2,
                          strokeColor: Colors.black,
                          child: Text(
                            anilistUserBox.get("anilistUserName"),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        const Text(
                          "arcanus reborn.",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            trailing: const Icon(Icons.tv),
            title: const Text(
              "Search anime",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              SearchType().isAnime = true;
              Navigator.of(context).pushNamed("/search_page");
            }
          ),
          ListTile(
            trailing: const Icon(Icons.book),
            title: const Text(
              "Search manga",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              SearchType().isAnime = false;
              Navigator.of(context).pushNamed("/search_page");
            }
          ),
          const Divider(),
          ListTile(
            trailing: const Icon(Icons.settings),
            title: const Text(
              "Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/settings_page");
            }
          ),
        ],
      ),
    );
  }
}