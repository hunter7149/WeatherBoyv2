import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherboy/configs/weather_api.dart';
import 'package:weatherboy/models/weather_model.dart';
import 'package:weatherboy/views/weatherscreen.dart';

import '../models/response_model.dart';

double lati = 0;
double long = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

void getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  // ignore: avoid_print
  lati = position.latitude;
  // ignore: avoid_print
  long = position.longitude;
}

@override
void initState() {
  getLocation();
}

Future<Weather> getWeather() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  // ignore: avoid_print
  lati = position.latitude;
  // ignore: avoid_print
  long = position.longitude;
  Weather weather;
  WeatherApi weatherApi = WeatherApi();

  final response = await weatherApi.getWeatherData(long, lati);
  if (response.status == ResponseStatus.success) {
    weather = Weather.fromJson(response.data);
  } else {
    weather = Weather(
        tempC: 0,
        cityName: 'null',
        maxTemp: 0,
        minTemp: 0,
        weatherType: 'none');
  }
  return weather;
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherApi weatherApi = WeatherApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          final Weather weather = snapshot.data as Weather;

          return WeatherScreen(weather: weather);

          // return a widget here (you have to return a widget to the builder)
        });
  }
}
