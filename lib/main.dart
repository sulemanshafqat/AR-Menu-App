import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const SpectoXRApp());
}

class SpectoXRApp extends StatelessWidget {
  const SpectoXRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpectoXR AR Menu',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}