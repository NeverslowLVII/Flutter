import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get cityApiKey => dotenv.get('CITY_API_KEY');
  static String get meteoApiKey => dotenv.get('METEO_API_KEY');
}
