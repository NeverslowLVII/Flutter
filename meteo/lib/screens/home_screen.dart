import 'package:flutter/material.dart';
import '../api/city_api_client.dart';
import '../api/weather_api_client.dart';
import '../models/city.dart';
import '../models/weather.dart';
import '../widgets/city_form.dart';
import '../widgets/map_display.dart';
import '../widgets/weather_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final CityApiClient _cityApiClient = CityApiClient();
  final WeatherApiClient _weatherApiClient = WeatherApiClient();
  Future<Weather>? _weatherFuture;
  City? _selectedCity;

  void _fetchWeather(String cityName) async {
    try {
      final city = await _cityApiClient.getCityCoordinates(cityName);
      setState(() {
        _selectedCity = city;
      });
      final weather =
          _weatherApiClient.fetchWeather(city.latitude, city.longitude);
      setState(() {
        _weatherFuture = weather;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching data: ${e.toString()}')),
        );
      }
    }
  }

  void _fetchWeatherData(double latitude, double longitude) {
    setState(() {
      _weatherFuture = _weatherApiClient.fetchWeather(latitude, longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CityForm(onCitySubmitted: (String cityName) {
              _fetchWeather(cityName);
            }),
            if (_selectedCity != null) MapDisplay(city: _selectedCity!),
            if (_weatherFuture != null)
              FutureBuilder<Weather>(
                future: _weatherFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return WeatherDisplay(weather: snapshot.data!);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
