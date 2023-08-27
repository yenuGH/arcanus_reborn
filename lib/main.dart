import 'package:arcanus_reborn/constants/arcanus_theme.dart';
import 'package:arcanus_reborn/controller/cubits/tab_bar/cubit/tab_bar_cubit.dart';
import 'package:arcanus_reborn/pages/home_page.dart';
import 'package:arcanus_reborn/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arcanus',
      theme: ArcanusTheme().arcanusTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TabBarCubit(), // changes media type from anime to manga and vise versa
          ),
        ],
        child: const HomePage(title: "arcanus"),
      ),
      onGenerateRoute: AppRoutes().onGenerateRoute,
    );
  }
}
