import 'package:flutter/material.dart';
import 'base_app.dart';
import 'loading_screen.dart';

class LoadingApp extends StatelessWidget {

  const LoadingApp({super.key, required this.message, this.subtitle});
  final String message;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return BaseApp(
      title: 'Loading',
      home: LoadingScreen(message: message, subtitle: subtitle),
    );
  }
}
