class City {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  }) {
    print('Creating City: $name, $country, $latitude, $longitude');
  }

  factory City.fromJson(Map<String, dynamic> json) {
    print('Creating City from JSON: ${json.toString()}');
    return City(
      name: json['name'],
      country: json['country'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }
}
