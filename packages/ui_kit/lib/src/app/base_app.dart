import 'package:flutter/material.dart';
import 'package:ui_kit/src/design_system/design_system.dart';

/// A base MaterialApp for simple screens like loading and error states.
class BaseApp extends StatelessWidget {
  const BaseApp({
    super.key,
    required this.title,
    required this.home,
  });

  final String title;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: KuiTheme.light(),
      darkTheme: KuiTheme.dark(),
      home: home,
    );
  }
}
