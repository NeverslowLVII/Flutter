import 'package:dio/dio.dart';
import '../env.dart';
import '../models/weather.dart';
import 'dart:developer' as developer;

class WeatherApiClient {
  final Dio _dio = Dio();

  Future<Weather> fetchWeather(double latitude, double longitude) async {
    final String apiKey = Env.meteoApiKey;
    const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
    developer.log('Fetching weather data for lat: $latitude, lon: $longitude',
        name: 'WeatherApiClient.fetchWeather');
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
      developer.log('Response received: ${response.statusCode}',
          name: 'WeatherApiClient.fetchWeather');

      if (response.statusCode == 200) {
        developer.log('Successfully loaded weather data',
            name: 'WeatherApiClient.fetchWeather');
        return Weather.fromJson(response.data);
      } else {
        developer.log(
            'Failed to load weather data with status code: ${response.statusCode}',
            name: 'WeatherApiClient.fetchWeather');
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      developer.log('Exception caught while fetching weather data: $e',
          name: 'WeatherApiClient.fetchWeather');
      throw Exception('Failed to load weather data: $e');
    }
  }
}
