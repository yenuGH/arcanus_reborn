import 'package:flutter/material.dart';

class AppDrawer extends Drawer {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(
                color: Colors.transparent,
              ),
            ),
            child: const DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide.none,
                ),
              ),
              child: Text(
                "Reborn"
              ),
            ),
          ),
          ListTile(
            trailing: const Icon(Icons.search),
            title: const Text(
              "Search",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/search_page");
            }
          ),
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