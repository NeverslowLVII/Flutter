import 'package:dio/dio.dart';
import '../env.dart';
import '../models/city.dart';

class CityApiClient {
  final Dio _dio = Dio();

  Future<City> getCityCoordinates(String cityName) async {
    try {
      final response = await _dio.get(
        'https://api.api-ninjas.com/v1/city',
        queryParameters: {'name': cityName},
        options: Options(
          headers: {'X-Api-Key': Env.cityApiKey},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data[0];
        return City.fromJson(data);
      } else {
        throw Exception('Failed to load city coordinates');
      }
    } on DioException catch (e) {
      throw Exception('DioError occurred: ${e.message}');
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }
}
