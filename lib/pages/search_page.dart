import 'dart:developer';

import 'package:arcanus_reborn/constants/search_type.dart';
import 'package:arcanus_reborn/controllers/blocs/search_media/search_media_bloc.dart';
import 'package:arcanus_reborn/widgets/media_result_card.dart';
import 'package:arcanus_reborn/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textFieldController = TextEditingController();
  late List<dynamic>? mediaList;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchMediaBloc>(context).add(SearchMediaInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchMediaBloc, SearchMediaState>(
      bloc: BlocProvider.of<SearchMediaBloc>(context),
      listener: (context, state) {
        if (state is SearchMediaLoadingState) {
          log("Loading animes and mangas...");
        }
        if (state is SearchMediaLoadedState) {
          mediaList = state.result;
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  textFieldController.clear();
                  mediaList = null;
                  BlocProvider.of<SearchMediaBloc>(context).add(SearchMediaInitialEvent());
                  Navigator.pop(context);
                },
              )
            ),
            body: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                ),
                SearchTextField(textFieldController: textFieldController),
                Container(
                  padding: const EdgeInsets.all(10.0),
                ),
                BlocBuilder<SearchMediaBloc, SearchMediaState>(
                  builder: (context, state) {
                    switch (state) {
                      case SearchMediaInitialState():
                        return Center(
                          child: SearchType().isAnime ? const Text("Search for an anime!") : const Text("Search for a manga!"),
                        );
                      case SearchMediaLoadingState():
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case SearchMediaLoadedState():
                        if (textFieldController.text.isEmpty) {
                          return Center(
                            child: SearchType().isAnime ? const Text("Search for an anime!") : const Text("Search for a manga!"),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: mediaList?.length,
                            itemBuilder: (context, index) {
                              return MediaResultCard(mediaResult: mediaList?[index]);
                            },
                          ),
                        );
                      default:
                        return const Center(
                          child: Text("No results found."),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
