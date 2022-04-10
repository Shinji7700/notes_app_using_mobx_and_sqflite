import 'package:flutter/material.dart';
import 'package:notes_app_using_sqflite/notes_app/screens/notes_screen.dart';
import 'package:notes_app_using_sqflite/notes_app/store/notes_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => NotesStore(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NotesScreen(),
      ),
    );
  }
}
