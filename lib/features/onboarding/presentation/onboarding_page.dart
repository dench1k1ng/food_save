import 'package:flutter/material.dart';
import 'package:food_save/core/theme/app_colors.dart';
import 'package:food_save/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:food_save/core/theme/theme_provider.dart';
import 'package:food_save/features/cart/presentation/menu_screen.dart';
import 'package:food_save/features/cart/provider/cart_provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  final List<Map<String, String>> items = const [
    {"image": "images/mcdon.png", "title": "McDonald's"},
    {"image": "images/magnum2.png", "title": "Magnum"},
    {"image": "images/kfcDed.png", "title": "KFC"},
    {"image": "images/small.png", "title": "Small"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;
    final bg = theme.scaffoldBackgroundColor;
    final textColor = isDark ? AppColors.darkText : AppColors.textDark;
    final cardBg = isDark ? AppColors.darkCard : AppColors.card;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg,
        title: Text(
          localizations.greeting, // "Добрый день!"
          style: theme.textTheme.titleMedium?.copyWith(color: textColor),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const MenuScreen(menuType: 'Заведения'),
                        ),
                      );
                    },
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('images/fermag.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      localizations.popular,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: Row(
                      children: const [
                        DiscountTag('-50%'),
                        DiscountTag('-40%'),
                        DiscountTag('-30%'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.all,
                    style:
                        theme.textTheme.titleLarge?.copyWith(color: textColor),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      localizations.viewAll,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return FoodItemCard(
                    imagePath: item['image']!,
                    title: item['title']!,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MenuScreen(
                          menuType: index % 2 == 0
                              ? localizations.establishments
                              : localizations.products,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscountTag extends StatelessWidget {
  final String label;
  const DiscountTag(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? Colors.redAccent.shade700 : Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const FoodItemCard(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.card,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : AppColors.shadow,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 80, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkText : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
