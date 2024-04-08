class Weather {
  final double temperature;
  final String cityName;
  final String country;

  Weather(
      {required this.temperature,
      required this.cityName,
      required this.country}) {
    print('Creating Weather: $cityName, $country, $temperature');
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    print('Creating Weather from JSON: ${json.toString()}');
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      cityName: json['name'],
      country: json['sys']['country'],
    );
  }
}
