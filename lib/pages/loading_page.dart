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
              return initializeUserAccount();
            }
            else if (state is UserMediaIntializingState) {
              return initializeUserAccount();
            }
            else if (state is UserMediaLoadingState) {
              return loadingUserDatabases();
            }
            else if (state is UserMediaLoadedState) {
              return Container();
            }
            else {
              return errorLoadingUserDatabases();
            }
          },
        ),
      ),
    );
  }

  Text initializeUserAccount() {
    return const Text(
      'Initializing user account...',
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
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeCap: StrokeCap.round,
        ),
        SizedBox(height: 20),
        Text('Loading user media lists...',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          )
        ),
      ],
    );
  }
}
