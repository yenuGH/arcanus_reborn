import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        child: const Text(
          "there's nothing to see here just yet\ncome back later",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}