import 'package:flutter/material.dart';

int hexToInteger(String hex) => int.parse(hex, radix: 16);

extension StringColorExtensions on String {
  Color toColor() => Color(hexToInteger(this));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget textField(@required String hintText) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          letterSpacing: 2,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        fillColor: Colors.grey.shade300,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
        title: const Text(
          'PROFILE',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("images/faceAvatar.jpeg")),
              SizedBox(
                height: 10,
              ),
              Text(
                "User",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              textField('Full name'),
              const SizedBox(
                height: 10,
              ),
              textField('Phone number'),
              const SizedBox(
                height: 10,
              ),
              textField('Gmail'),
              const SizedBox(
                height: 10,
              ),
              textField('Addres'),
            ],
          ),
        ],
      ),
    );
  }
}
