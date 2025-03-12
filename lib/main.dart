import 'package:firebase_core/firebase_core.dart';
import 'package:firecrud5b25/screens/artist_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi música - Flutter Firebase CRUD',
      home: const ArtistScreen(),
    );
  }
}
