import "package:flutter/material.dart";

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'FAVOURITE',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
