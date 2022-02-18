import 'dart:developer';
import '../models/response_model.dart';
import 'keys.dart';
import 'package:dio/dio.dart';

class WeatherApi {
  Dio dio = Dio();
  Future<ResponseModel> getWeatherData(double long, double lati) async {
    try {
      final Response responseData = await dio.get(
        apiBaseUrl + weatherByCityEndpoint,
        queryParameters: {
          'lat': lati,
          'lon': long,
          'appid': weatherApiKey,
        },
      );

      log(responseData.statusCode.toString());

      if (responseData.statusCode == 200 && responseData.data['cod'] == 200) {
        return ResponseModel(
          status: ResponseStatus.success,
          message: 'Weather data fetched successfully',
          data: responseData.data,
        );
      } else {
        return ResponseModel(
          status: ResponseStatus.failed,
          message: 'Weather data fetch failed',
          data: responseData.data,
        );
      }
    } catch (e) {
      return ResponseModel(
        status: ResponseStatus.failed,
        message: e.toString(),
        data: null,
      );
    }
  }
}
