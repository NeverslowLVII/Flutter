import 'package:dio/dio.dart';
import '../env.dart';
import '../models/city.dart';

class CityApiClient {
  final Dio _dio = Dio();

  Future<City> getCityCoordinates(String cityName) async {
    print('Attempting to fetch city coordinates for: $cityName');
    try {
      final response = await _dio.get(
        'https://api.api-ninjas.com/v1/city',
        queryParameters: {'name': cityName},
        options: Options(
          headers: {'X-Api-Key': Env.cityApiKey},
        ),
      );
      print(
          'Response received for city: $cityName with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data[0];
        print(
            'Successfully fetched city coordinates for: $cityName, data: $data');
        return City.fromJson(data);
      } else {
        print(
            'Failed to load city coordinates for: $cityName, status code: ${response.statusCode}');
        throw Exception('Failed to load city coordinates');
      }
    } on DioException catch (e) {
      print(
          'DioException occurred while fetching city coordinates for: $cityName, message: ${e.message}');
      throw Exception('DioError occurred: ${e.message}');
    } catch (e) {
      print(
          'An error occurred while fetching city coordinates for: $cityName, error: ${e.toString()}');
      throw Exception('An error occurred: ${e.toString()}');
    }
  }
}
