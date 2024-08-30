import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});
  static String name = "/unknown";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Unknown Screen",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
