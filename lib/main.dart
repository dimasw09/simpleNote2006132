import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simple_note/models/note.dart';
import 'package:simple_note/utils/routes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox('noteBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green[50],
        primaryColor: Colors.green[700],
        accentColor: Colors.green[500],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
          elevation: 8,
          hoverElevation: 12,
          focusElevation: 12,
          splashColor: Colors.green[900],
        ),
      ),
      title: "Simple Note",
      routeInformationParser: Approutes.router.routeInformationParser,
      routerDelegate: Approutes.router.routerDelegate,
      routeInformationProvider: Approutes.router.routeInformationProvider,
    );
  }
}
