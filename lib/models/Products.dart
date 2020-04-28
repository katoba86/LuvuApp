import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:luvutest/models/Product.dart';

class Products extends ChangeNotifier{
  final List<Product> _items = [];
  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);
  int get totalItems => _items.length;


  void add(Product item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}