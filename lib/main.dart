import 'package:flutter/material.dart';

import 'screens/layar_splash.dart';

void main() {
  runApp(const SevenKingdomsApp());
}

class SevenKingdomsApp extends StatelessWidget {
  const SevenKingdomsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Thrones',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFF8B0000),
          surface: Color(0xFF121212),
        ),
      ),
      home: const LayarSplash(),
    );
  }
}
