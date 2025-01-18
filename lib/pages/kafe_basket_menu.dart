import 'package:flutter/material.dart';

class KafeBasketMenu extends StatelessWidget {
  final String title;

  const KafeBasketMenu({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          "Welcome to Screen A for $title",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
