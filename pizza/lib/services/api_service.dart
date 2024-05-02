import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final _cache = <String, dynamic>{};

  Future<List<dynamic>> fetchPizzasList() async {
    const url = 'https://pizzas.shrp.dev/items/pizzas';
    if (_cache.containsKey(url)) {
      return _cache[url];
    }
    try {
      final response = await _dio.get(url);
      final data = response.data['data'];
      _cache[url] = data;
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> signUp(String role, String firstname, String lastname,
      String email, String password) async {
    const url = 'https://pizzas.shrp.dev/users';
    try {
      await _dio.post(url, data: {
        'role': 'bad526d9-bc5a-45f1-9f0b-eafadcd4fc15',
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'password': password
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    const url = 'https://pizzas.shrp.dev/auth/login';
    try {
      await _dio.post(url, data: {'email': email, 'password': password});
    } catch (e) {
      print(e);
    }
  }
}
