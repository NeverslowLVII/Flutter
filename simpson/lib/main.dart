import 'package:flutter/material.dart';
import 'homer.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpson',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.kalam().fontFamily,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simpson'),
        ),
        body: const Center(
          child: Homer(),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
