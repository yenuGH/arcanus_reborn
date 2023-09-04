import 'package:arcanus_reborn/controllers/blocs/search_media/search_media_bloc.dart';
import 'package:arcanus_reborn/widgets/search_anime_text_field.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<SearchMediaBloc>(context).add(SearchMediaInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchMediaBloc, SearchMediaState>(
      bloc: BlocProvider.of<SearchMediaBloc>(context),
      listener: (context, state) {
        if (state is SearchMediaLoadingState){
          print("Loading animes and mangas...");
        }
        if (state is SearchMediaLoadedState){
          print("Loaded animes and mangas!");
          for (int i = 0; i < state.result.length; i++){
            print(state.result[i].title);
            print(state.result[i].type);
            print("\n");print("\n");print("\n");
          }
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

              SearchAnimeTextField(textFieldController: textFieldController),

              Container(
                padding: const EdgeInsets.all(10.0),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Testing $index"),
                      subtitle: Text("Subtitle $index"),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
