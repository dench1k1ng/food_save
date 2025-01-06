import 'package:flutter/material.dart';
import 'package:food_save/auth/auth_service.dart';
import 'package:food_save/pages/favourite_page.dart';
import 'package:food_save/pages/profile_page.dart';
import 'package:food_save/pages/search_page.dart';

int hexToInteger(String hex) => int.parse(hex, radix: 16);

extension StringColorExtensions on String {
  Color toColor() => Color(hexToInteger(this));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() {
    final auth = AuthService();
    auth.signout();
  }

  int myIndex = 0;
  List<Widget> widgetList = [
    HomePage(),
    SearchPage(),
    FavouritePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Color(hexToInteger('FF154314')),
        title: const Text('Home page'),
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: IndexedStack(
          children: widgetList,
          index: myIndex,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: '',
              icon: Icon(
                Icons.home,
                color: Color(hexToInteger('FF154314')),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: '',
              icon: Icon(
                Icons.search,
                color: Color(hexToInteger('FF154314')),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: '',
              icon: Icon(
                Icons.favorite,
                color: Color(hexToInteger('FF154314')),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.person,
                color: Color(hexToInteger('FF154314')),
              ),
            ),
          ]),
    );
  }
}
