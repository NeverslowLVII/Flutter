import 'package:dio/dio.dart';
import '../env.dart';
import '../models/weather.dart';

class WeatherApiClient {
  final Dio _dio = Dio();

  Future<Weather> fetchWeather(double latitude, double longitude) async {
    final String apiKey = Env.meteoApiKey;
    const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {
          'lat': latitude.toString(),
          'lon': longitude.toString(),
          'appid': apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}
