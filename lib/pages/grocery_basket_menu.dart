import 'package:flutter/material.dart';

class GroceryBasketMenu extends StatelessWidget {
  final String title;

  const GroceryBasketMenu({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          "Welcome to Screen B for $title",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
