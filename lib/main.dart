import 'package:arcanus_reborn/constants/arcanus_theme.dart';
import 'package:arcanus_reborn/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // ignore: unused_local_variable
  var tokenBox = await Hive.openBox('userToken');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final tokenBox = Hive.box('userToken');

  @override
  Widget build(BuildContext context) {
    if (tokenBox.get("token") == null){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arcanus',
        theme: ArcanusTheme().arcanusTheme,
        initialRoute: "/login_page",
        onGenerateRoute: AppRoutes().onGenerateRoute,
      );
    }
    else{
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arcanus',
        theme: ArcanusTheme().arcanusTheme,
        initialRoute: "/loading_page",
        onGenerateRoute: AppRoutes().onGenerateRoute,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
