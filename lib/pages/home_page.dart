import 'package:flutter/material.dart';
import 'package:food_save/auth/auth_service.dart';
import 'package:food_save/pages/favourite_page.dart';
import 'package:food_save/pages/profile_page.dart';
import 'package:food_save/pages/search_page.dart';

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
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.green,
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
              backgroundColor: Colors.amber,
              label: '1',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.amber,
              label: '2',
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.amber,
              label: '3',
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              label: '4',
              backgroundColor: Colors.amber,
              icon: Icon(Icons.person),
            ),
          ]),
    );
  }
}
