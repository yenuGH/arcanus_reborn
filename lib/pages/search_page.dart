import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        elevation: 0.0,
      ),

      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
          ),

          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              labelText: 'Search',
              suffixIcon: GestureDetector(
                child: const Icon(Icons.clear_rounded),
                onTap: () {
                  textFieldController.clear();
                }
              ),
              contentPadding: const EdgeInsets.all(10.0),
            ),

            controller: textFieldController,
          ),

          Container(
            padding: const EdgeInsets.all(10.0),
          ),

          //const SearchView(),
        ],
      ),
    );
  }
}