import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  Map<String, dynamic> _userData = {};

  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic> get userData => _userData;

  void login(String email, String password) {
    _isLoggedIn = true;
    _userData = {'email': email};
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userData = {};
    notifyListeners();
  }
}
