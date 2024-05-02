import 'package:flutter/foundation.dart';

class FavoriteModel extends ChangeNotifier {
  final List<dynamic> _favoriteItems = [];
  List<dynamic> get favoriteItems => _favoriteItems;

  void addFavorite(dynamic item) {
    if (!_favoriteItems.any((i) => i['id'] == item['id'])) {
      _favoriteItems.add(item);
      notifyListeners();
    }
  }

  void removeFavorite(dynamic item) {
    _favoriteItems.removeWhere((i) => i['id'] == item['id']);
    notifyListeners();
  }

  bool isFavorite(dynamic item) {
    return _favoriteItems.any((i) => i['id'] == item['id']);
  }
}
