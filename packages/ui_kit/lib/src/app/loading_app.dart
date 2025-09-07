import 'package:flutter/material.dart';
import 'loading_screen.dart';

class LoadingApp extends StatelessWidget {
  final String message;
  final String? subtitle;

  const LoadingApp({super.key, required this.message, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: LoadingScreen(message: message, subtitle: subtitle),
    );
  }
}
