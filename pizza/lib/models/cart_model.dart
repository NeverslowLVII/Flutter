import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  final List<dynamic> _items = [];
  List<dynamic> get items => _items;

  void addItem(dynamic item) {
    var foundItem =
        _items.firstWhere((i) => i['id'] == item['id'], orElse: () => null);
    if (foundItem != null) {
      foundItem['quantity'] += 1;
    } else {
      var newItem = Map.from(item);
      newItem['quantity'] = 1;
      _items.add(newItem);
    }
    notifyListeners();
  }

  void removeItem(dynamic item) {
    _items.remove(item);
    notifyListeners();
  }

  double get totalPrice => _items.fold(
      0.0,
      (total, current) =>
          total + (current['price'] ?? 0) * (current['quantity'] ?? 1));
}
