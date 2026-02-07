import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Code',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Uses system setting for light/dark
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}