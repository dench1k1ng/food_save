import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<String, int> _selectedItems = {}; // Храним товары и их количество
  final List<Map<String, dynamic>> _items = []; // Храним список товаров

  Map<String, int> get selectedItems => _selectedItems;
  List<Map<String, dynamic>> get items => _items;

  // Геттер для получения общего количества товаров
  int get totalItems =>
      _selectedItems.values.fold(0, (sum, quantity) => sum + quantity);

  void addItem(Map<String, dynamic> item) {
    if (_selectedItems.containsKey(item['title'])) {
      _selectedItems[item['title']] = _selectedItems[item['title']]! + 1;
    } else {
      _selectedItems[item['title']] = 1;
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(Map<String, dynamic> item) {
    final title = item['title'] as String;
    if (_selectedItems.containsKey(title)) {
      if (_selectedItems[title]! > 1) {
        _selectedItems[title] = _selectedItems[title]! - 1;
      } else {
        _selectedItems.remove(title);
        _items.removeWhere((i) => i['title'] == title);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _selectedItems.clear();
    _items.clear();
    notifyListeners();
  }
}
