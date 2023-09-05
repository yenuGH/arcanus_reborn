import 'package:arcanus_reborn/controllers/cubits/anilist_login/anilist_login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// Widget for 'Remember Me'
  bool rememberMe = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;

  Widget buildRememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: BlocBuilder<AnilistLoginCubit, AnilistLoginState>(
              builder: (context, state) {
                if (state is AnilistLoginSavedState) {
                  rememberMe = true;
                } else if (state is AnilistLoginNotSavedState) {
                  rememberMe = false;
                } else {
                  rememberMe = false;
                }

                return Checkbox(
                  value: rememberMe,
                  checkColor: Colors.blue,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    if (value == true) {
                      BlocProvider.of<AnilistLoginCubit>(context)
                          .saveAnilistLogin();
                    }
                    if (value == false) {
                      BlocProvider.of<AnilistLoginCubit>(context)
                          .notSaveAnilistLogin();
                    }
                  },
                );
              },
            ),
          ),
          const Text(
            'Remember Me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  // The actual login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          buildEmail(),
                          // Create indent box
                          // Create password widget
                          const SizedBox(height: 50),
                          buildPassword(),
                          const SizedBox(height: 15),
                          // Create smaller indent box
                          // Create remember me widget
                          buildRememberMe(),
                          // Create login widget/button
                          buildLoginButton(context),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget buildPassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Password',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
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
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.lock, color: Color(0xff6B7AFD)),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black38)),
              onChanged: (value) {
                password = value;
              },
              onSubmitted: (value) {
                password = value;
              },
            ),
          )
        ]);
  }

  Widget buildEmail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Email Address',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.email, color: Color(0xff6B7AFD)),
                  hintText: 'AniList Associated Email',
                  hintStyle: TextStyle(color: Colors.black38)),
              onChanged: (value) {
                email = value;
              },
              onSubmitted: (value) {
                email = value;
              },
            ),
          )
        ]);
  }

  Widget buildLoginButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          //Navigator.pushReplacementNamed(context, "/home_page");
          // get access token based on login credentials
          // if successful, go to home page
          // if unsuccessful, show error message

          BlocProvider.of<AnilistLoginCubit>(context).anilistLoginPressed(
              email!, password!); // 
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
