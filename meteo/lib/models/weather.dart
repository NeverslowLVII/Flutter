class Weather {
  final double temperature;
  final String cityName;
  final String country;

  Weather(
      {required this.temperature,
      required this.cityName,
      required this.country});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      cityName: json['name'],
      country: json['sys']['country'],
    );
  }
}
