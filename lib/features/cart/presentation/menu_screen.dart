import 'package:flutter/material.dart';
import 'package:food_save/core/theme/app_colors.dart';
import 'package:food_save/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:food_save/features/cart/provider/cart_provider.dart';
import 'basket_screen.dart';

class MenuScreen extends StatelessWidget {
  final String menuType;

  const MenuScreen({Key? key, required this.menuType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final localizations = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final items = menuType == localizations.products
        ? [
            {'image': 'images/gro/app.jpg', 'title': 'Яблоки', 'price': 300},
            {'image': 'images/gro/banana.jpg', 'title': 'Бананы', 'price': 500},
            {'image': 'images/gro/milk.jpg', 'title': 'Молоко', 'price': 450},
            {'image': 'images/gro/bread.jpg', 'title': 'Хлеб', 'price': 150},
            {
              'image': 'images/gro/straw.jpg',
              'title': 'Клубника',
              'price': 900
            },
            {'image': 'images/gro/cokki.jpg', 'title': 'Печенье', 'price': 700},
          ]
        : [
            {'image': 'images/beh/combo.jpg', 'title': 'Комбо', 'price': 1500},
            {'image': 'images/beh/bulki.jpg', 'title': 'Самса', 'price': 700},
            {'image': 'images/beh/doner.jpg', 'title': 'Донер', 'price': 800},
            {
              'image': 'images/beh/free.jpg',
              'title': 'Картошка фри',
              'price': 400
            },
            {
              'image': 'images/beh/lagman.jpg',
              'title': 'Лагман',
              'price': 1000
            },
            {'image': 'images/beh/pizza.jpg', 'title': 'Пицца', 'price': 1400},
            {'image': 'images/beh/ploov.jpg', 'title': 'Плов', 'price': 1200},
            {'image': 'images/beh/sup.jpg', 'title': 'Суп', 'price': 900},
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text('${menuType} ${localizations.menu}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: localizations.search,
                prefixIcon: Icon(Icons.search, color: AppColors.primaryGreen),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final title = item['title'] as String;
                  final count = cartProvider.selectedItems[title] ?? 0;
                  return ProductCard(
                    imagePath: item['image'] as String,
                    title: title,
                    price: item['price'] as int,
                    count: count,
                    onAdd: () => cartProvider.addItem(item),
                    onRemove: () => cartProvider.removeItem(item),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: cartProvider.selectedItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => BasketScreen()),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    localizations.goToCart,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final int price;
  final int count;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.count,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkCard : AppColors.card;
    final localizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '$price ₸',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryGreen),
                ),
                const SizedBox(height: 8),
                CartButton(
                  count: count,
                  onAdd: onAdd,
                  onRemove: onRemove,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  final int count;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartButton({
    Key? key,
    required this.count,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkDivider : AppColors.border;
    final bgColor = isDark ? AppColors.darkCard : AppColors.card;
    final addButtonColor = AppColors.primaryGreen;
    final textColor = isDark ? AppColors.darkText : AppColors.textDark;

    // Кнопка «Добавить в корзину»
    if (count == 0) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onAdd,
          style: ElevatedButton.styleFrom(
            backgroundColor: addButtonColor,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            AppLocalizations.of(context)!.addToCart,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    // Шаговый контрол «− [count] +»
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.remove),
            color: addButtonColor,
          ),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          IconButton(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            color: addButtonColor,
          ),
        ],
      ),
    );
  }
}
