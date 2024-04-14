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
}
