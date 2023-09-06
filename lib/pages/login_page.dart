import 'dart:io';

import 'package:arcanus_reborn/controllers/cubits/anilist_login/anilist_login_cubit.dart';
import 'package:arcanus_reborn/graphql/anilist_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController authTokenController = TextEditingController();
  String? authToken;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnilistLoginCubit, AnilistLoginState>(
      listener: (context, state) {
        if (state is AnilistLoginPressedState) {
          if (Platform.isIOS){
            AnilistClient().helper.getTokenFromStorage().then((token) {
              if (token != null) {
                Navigator.pushNamed(context, "/home_page");
              } else {
                BlocProvider.of<AnilistLoginCubit>(context).anilistLoginError();
              }
            });
          }
          if (Platform.isAndroid){
            final tokenBox = Hive.box('userToken');
            if (tokenBox.get("token") != null) {
              Navigator.pushNamed(context, "/home_page");
            } else {
              BlocProvider.of<AnilistLoginCubit>(context).anilistLoginError();
            }
          }
        }
        if (state is AnilistLoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login error, please try again."),
              duration: Duration(milliseconds: 700),
            ),
          );
          BlocProvider.of<AnilistLoginCubit>(context).anilistLoginInitial();
        }
      },
      child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: GestureDetector(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          // Creating a background
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color(0x666B7AFD),
                            Color(0x996B7AFD),
                            Color(0xcc6B7AFD),
                            Color(0xff6B7AFD),
                          ])),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 120,
                        ),
                        // Creating a column for title, widgets/buttons
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Log Into AniList',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Create indent box
                            // Create email widget
                            const SizedBox(height: 50),
                            
                            Platform.isAndroid ? authTokenField() : Container(),
                            
                            const SizedBox(height: 50),

                            loginButton(context),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }

  Widget authTokenField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Authorization Token',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: authTokenController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: GestureDetector(
                    child: const Icon(
                      Icons.token, 
                      color: Color(0xff6B7AFD)
                    ),
                    onTap:() {
                      BlocProvider.of<AnilistLoginCubit>(context)
                          .anilistLoginGrabToken();
                    },
                  ),
                  hintText: 'Tap the icon to grab your token.',
                  hintStyle: const TextStyle(color: Colors.black38)),
              onChanged: (value) {
                authToken = value;
              },
              onSubmitted: (value) {
                authToken = value;
              },
            ),
            
          )
        ]);
  }

  Widget loginButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (Platform.isIOS){
            BlocProvider.of<AnilistLoginCubit>(context)
                .anilistLoginPressedIOS();
          }
          if (Platform.isAndroid){
            BlocProvider.of<AnilistLoginCubit>(context)
                .anilistLoginPressedAndroid(authToken);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(
              color: Color(0xff6B7AFD),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
