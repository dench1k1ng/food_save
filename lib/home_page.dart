import 'package:flutter/material.dart';
import 'package:food_save/core/theme/app_colors.dart';
import 'package:food_save/features/cart/presentation/basket_screen.dart';
import 'package:food_save/features/onboarding/presentation/onboarding_page.dart';
import 'package:food_save/features/profile/presentation/profile_page.dart';
import 'package:food_save/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_save/features/cart/provider/cart_provider.dart';

Future<Map<String, String>> loadUserData() async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'name': prefs.getString('name') ?? 'Гость',
    'email': prefs.getString('email') ?? 'guest@example.com',
  };
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late Future<List<Widget>> _widgetListFuture;

  @override
  void initState() {
    super.initState();
    _widgetListFuture = _loadWidgets();
  }

  Future<List<Widget>> _loadWidgets() async {
    final userData = await loadUserData();
    return [
      const OnboardingPage(),
      BasketScreen(),
      ProfilePage(
        name: userData['name']!,
        email: userData['email']!,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.scaffoldBackgroundColor;
    final iconColor = isDark ? AppColors.primaryGreen : AppColors.textDark;
    final badgeColor = Colors.redAccent;
    final badgeTextColor = Colors.white;

    return Scaffold(
      body: FutureBuilder<List<Widget>>(
        future: _widgetListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
              localizations.loadingError,
              style: theme.textTheme.bodyMedium,
            ));
          }
          final widgetList = snapshot.data!;
          return IndexedStack(
            index: _currentIndex,
            children: widgetList,
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: bgColor,
            selectedItemColor: AppColors.primaryGreen,
            unselectedItemColor: iconColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.home, color: iconColor),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Stack(
                  children: [
                    Icon(Icons.shopping_basket, color: iconColor),
                    if (cartProvider.totalItems > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${cartProvider.totalItems}',
                            style: TextStyle(
                              color: badgeTextColor,
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
                icon: Icon(Icons.person, color: iconColor),
              ),
            ],
          );
        },
      ),
    );
  }
}
