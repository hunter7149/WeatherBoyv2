class Weather {
  late final double tempC;
  late final String cityName;
  late final double maxTemp;
  late final double minTemp;
  late final dynamic weatherType;

  Weather(
      {required this.tempC,
      required this.cityName,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherType});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weathertp = json['weather'];
    return Weather(
        tempC: kelvinToCelcius(main["temp"]),
        cityName: json["name"],
        maxTemp: kelvinToCelcius(main["temp_max"]),
        minTemp: kelvinToCelcius(main["temp_max"]),
        weatherType: weathertp[0]["main"]);
  }
  static double kelvinToCelcius(num value) {
    return value - 273;
  }
}
