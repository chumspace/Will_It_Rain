import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:will_it_rain/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(
      String? location1, String? location2) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$location1&lon=-$location2&appid=a8883f3d7612432fed1ca51cba71e4bc&units=imperial");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
