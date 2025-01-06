import 'package:flutter/material.dart';

int hexToInteger(String hex) => int.parse(hex, radix: 16);

extension StringColorExtensions on String {
  Color toColor() => Color(hexToInteger(this));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color(hexToInteger('FF154314')),
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
