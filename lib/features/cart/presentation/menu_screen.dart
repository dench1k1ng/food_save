import 'package:flutter/material.dart';
import 'package:food_save/features/cart/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'basket_screen.dart';

class MenuScreen extends StatelessWidget {
  final String menuType;

  const MenuScreen({Key? key, required this.menuType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final List<Map<String, dynamic>> items = menuType == "Продукты"
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
        title: Text('$menuType Меню'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Поле поиска
            TextField(
              decoration: InputDecoration(
                labelText: 'Поиск',
                prefixIcon: Icon(Icons.search, color: Colors.green[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Сетка товаров
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
                  return ProductCard(
                    imagePath: item['image'],
                    title: item['title'],
                    price: item['price'],
                    isSelected:
                        cartProvider.selectedItems.containsKey(item['title']),
                    onTap: () => cartProvider.addItem(item),
                  );
                },
              ),
            ),

            // Кнопка "Перейти в корзину"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: cartProvider.selectedItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BasketScreen()),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Перейти в корзину'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Карточка товара
class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final int price;
  final bool isSelected;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "$price ₸",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(isSelected ? "Добавлено" : "Добавить"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
