import 'package:flutter/material.dart';
import 'package:weatherboy/models/weather_model.dart';

class WeatherScreen extends StatelessWidget {
  final Weather weather;
  const WeatherScreen({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const Icon(Icons.search),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10, bottom: 7),
              child: Icon(Icons.settings),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Image.asset(
              "assets/images/winter.jpg",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 5.0,
              left: MediaQuery.of(context).size.width / 3.3,
              child: SizedBox(
                child: Center(
                  child: Text(
                    weather.tempC.toStringAsFixed(1) + "°C",
                    style: const TextStyle(fontSize: 80, color: Colors.white),
                  ),
                ),
                width: 200,
                height: 200,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.4,
              left: MediaQuery.of(context).size.width / 3.6,
              child: SizedBox(
                child: Center(
                  child: Text(
                    weather.weatherType.toString(),
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                width: 200,
                height: 200,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.3,
              left: MediaQuery.of(context).size.width - 450,
              child: SizedBox(
                child: Center(
                  child: Text(
                    "HIGH:" + weather.maxTemp.toStringAsFixed(1) + "°C",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                width: 200,
                height: 200,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.3,
              left: MediaQuery.of(context).size.width - 150,
              child: SizedBox(
                child: Center(
                  child: Text(
                    "LOW:" + weather.minTemp.toStringAsFixed(1) + "°C",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                width: 200,
                height: 200,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 1.5,
              left: MediaQuery.of(context).size.width / 3.6,
              child: SizedBox(
                child: Center(
                  child: Text(
                    weather.cityName.toString(),
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                width: 200,
                height: 200,
              ),
            ),
          ],
        ));
  }
}
