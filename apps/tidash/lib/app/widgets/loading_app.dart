import 'package:flutter/material.dart';
import 'package:tidash/app/widgets/loading_screen.dart';

class LoadingApp extends StatelessWidget {

  const LoadingApp({super.key, required this.message, this.subtitle});
  final String message;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TiDash Loading',
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
