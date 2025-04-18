import 'package:flutter/material.dart';

class ShopProductsPage extends StatelessWidget {
  final String shopName;

  ShopProductsPage({Key? key, required this.shopName}) : super(key: key);

  final List<Map<String, dynamic>> products = [
    {'image': 'images/gro/app.jpg', 'title': 'Яблоки', 'price': 300},
    {'image': 'images/gro/banana.jpg', 'title': 'Бананы', 'price': 500},
    {'image': 'images/gro/milk.jpg', 'title': 'Молоко', 'price': 450},
    {'image': 'images/gro/bread.jpg', 'title': 'Хлеб', 'price': 150},
    {'image': 'images/gro/straw.jpg', 'title': 'Клубника', 'price': 900},
    {'image': 'images/gro/cokki.jpg', 'title': 'Печеньки', 'price': 700},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          shopName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Товары от $shopName",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 10),

            // Сетка товаров
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    imagePath: product['image'],
                    title: product['title'],
                    price: product['price'],
                    onTap: () {
                      // Действие при нажатии на товар
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Добавлено: ${product['title']}")),
                      );
                    },
                  );
                },
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
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
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
                height: 120,
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
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Добавить"),
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
