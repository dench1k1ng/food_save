import 'package:flutter/material.dart';
import 'package:food_save/features/cart/presentation/basket_screen.dart';
import 'package:food_save/features/cart/provider/cart_provider.dart';
import 'package:food_save/features/onboarding/presentation/onboarding_page.dart';
import 'package:food_save/features/profile/presentation/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String>> loadUserData() async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'name': prefs.getString('name') ?? 'Гость',
    'email': prefs.getString('email') ?? 'guest@example.com',
  };
}

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
  int myIndex = 0;
  late Future<List<Widget>> widgetListFuture;

  @override
  void initState() {
    super.initState();
    widgetListFuture = _loadWidgets();
  }

  Future<List<Widget>> _loadWidgets() async {
    final userData = await loadUserData();
    return [
      OnboardingPage(),
      BasketScreen(),
      ProfilePage(
        name: userData['name']!,
        email: userData['email']!,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Widget>>(
        future: widgetListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки данных'));
          }
          final widgetList = snapshot.data ?? [];

          return IndexedStack(
            index: myIndex,
            children: widgetList,
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                myIndex = index;
              });
            },
            currentIndex: myIndex,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.home,
                  color: Color(hexToInteger('FF154314')),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Stack(
                  children: [
                    Icon(
                      Icons.shopping_basket,
                      color: Color(hexToInteger('FF154314')),
                    ),
                    if (cartProvider.totalItems > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${cartProvider.totalItems}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.person,
                  color: Color(hexToInteger('FF154314')),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
