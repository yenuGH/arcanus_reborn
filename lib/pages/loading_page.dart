import 'dart:developer';

import 'package:arcanus_reborn/controllers/blocs/user_media/user_media_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserMediaBloc>(context).add(UserMediaInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UserMediaBloc, UserMediaState>(
          builder: (_, state) {
            if (state is UserMediaInitialState){
              log("LoadingPage: Initialized");
              return initializeLoginPage();
            }
            else if (state is UserMediaLoadingState) {
              log("LoadingPage: Loading user databases");
              return loadingUserDatabases();
            }
            else {
              return errorLoadingUserDatabases();
            }
          },
        ),
      ),
    );
  }

  Text initializeLoginPage() {
    return const Text(
      'Initializing...',
      style: TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Container errorLoadingUserDatabases() {
    return Container(
      alignment: Alignment.center,
      child: const Text(
          "Failed to load user media, please re-open the application."),
    );
  }

  Column loadingUserDatabases() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text('Loading user databases...'),
      ],
    );
  }
}
