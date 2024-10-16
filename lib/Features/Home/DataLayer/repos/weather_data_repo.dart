import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/WeatherModel.dart';

class WeatherDataRepo {
  Future<WeatherDataModel> getWeatherData({String country = 'Egypt'}) async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.weatherapi.com/v1/forecast.json?key=77e5f22ce22644938b9160110241610&q=$country&days=1&aqi=no&alerts=no'));
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        return WeatherDataModel.fromJson(data);
      } else {
        // Different error for non-200 response
        throw Exception(
            'Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Improved error message for better debugging
      throw Exception('Failed to load weather data: $error');
    }
  }
}
