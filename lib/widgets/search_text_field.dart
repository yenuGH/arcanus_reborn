import 'package:arcanus_reborn/controllers/blocs/search_media/search_media_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.textFieldController,
  });

  final TextEditingController textFieldController;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        BlocProvider.of<SearchMediaBloc>(context)
            .add(SearchMediaNewQueryEvent(query: value));
      },
      onChanged: (String value) {
        BlocProvider.of<SearchMediaBloc>(context)
            .add(SearchMediaNewQueryEvent(query: value));
      },
    );
  }
}

