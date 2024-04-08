class City {
  String name;
  String country;
  double latitude = 48;
  double longitude = 3;

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
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
