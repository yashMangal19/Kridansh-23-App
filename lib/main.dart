import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/homepage.dart';

void main() {
  runApp(const KridanshApp());
}

class KridanshApp extends StatelessWidget {
  const KridanshApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kridansh 23',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
