import 'package:flutter/material.dart';
import 'package:food_save/features/cart/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final cartProvider = Provider.of<CartProvider>(context);
    double totalPrice = 0;

    cartProvider.selectedItems.forEach((title, quantity) {
      final item =
          cartProvider.items.firstWhere((item) => item['title'] == title);
      totalPrice += item['price'] * quantity;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.selectedItems.isEmpty
                ? const Center(child: Text("Корзина пуста"))
                : ListView.builder(
                    itemCount: cartProvider.selectedItems.length,
                    itemBuilder: (context, index) {
                      final itemTitle =
                          cartProvider.selectedItems.keys.elementAt(index);
                      final quantity = cartProvider.selectedItems[itemTitle];
                      final item = cartProvider.items
                          .firstWhere((item) => item['title'] == itemTitle);

                      return ListTile(
                        leading:
                            Image.asset(item['image'], width: 50, height: 50),
                        title: Text(item['title']),
                        subtitle: Text('Цена: ${item['price']} тенге'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  cartProvider.removeItem(item),
                            ),
                            Text('$quantity'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => cartProvider.addItem(item),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Всего: ${totalPrice.toStringAsFixed(2)} тенге',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: cartProvider.selectedItems.isEmpty
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Оплатить'),
                              content: Text(
                                  'Общая цена ${totalPrice.toStringAsFixed(2)} тенге.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Отмена'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cartProvider.clearCart();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Подтвердить'),
                                ),
                              ],
                            );
                          },
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
                child: const Text('Подтвердить оплату'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
