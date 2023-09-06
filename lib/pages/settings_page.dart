import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              logoutDialog(context);
            },
            leading: const Icon(Icons.logout),
          ),

          ListTile(
            title: const Text("About"),
            onTap: () {
              Navigator.pushNamed(context, "/about_page");
            },
            leading: const Icon(Icons.info),
          ),
        ],
      ),
    );
  }

  void logoutDialog(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Logout?"),
      content: const Text(
        "Are you sure you want to logout?\nYou will need to login again to continue using the app.",
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "No",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            final tokenBox = Hive.box('userToken');
            tokenBox.delete("token");

            AnilistClient().helper.removeAllTokens();

            Navigator.pushReplacementNamed(context, "/login_page");
          },
          child: const Text(
            "Yes",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }
}