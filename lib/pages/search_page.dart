import 'package:arcanus_reborn/controllers/blocs/search_anime/search_anime_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchAnimeBloc, SearchAnimeState>(
      bloc: SearchAnimeBloc(),
      listener: (context, state) {
        if (state is SearchAnimeLoaded) {
          // ignore: avoid_print
          print("The result is: " + state.result.data.toString());
        }
        else {
          // ignore: avoid_print
          print("The state is: " + state.toString());
        }
      },
      builder: (context, state) {
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
                      }),
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                controller: textFieldController,
                onSubmitted: (String value) {
                  BlocProvider.of<SearchAnimeBloc>(context)
                      .add(SearchAnimeNewQueryEvent(query: value));
                },
                onChanged: (String value) {
                  BlocProvider.of<SearchAnimeBloc>(context)
                      .add(SearchAnimeNewQueryEvent(query: value));
                },
              ),

              Container(
                padding: const EdgeInsets.all(10.0),
              ),

              //const SearchView(),
            ],
          ),
        );
      },
    );
  }
}
