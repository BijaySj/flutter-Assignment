import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var temperature = ''.obs;
  var description = ''.obs;
  var weatherMain = ''.obs; // ✅ new
  var city = 'Kathmandu'.obs;

  var forecast = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchWeather();
    fetchForecast();
    super.onInit();
  }

  Future<void> fetchWeather() async {
    final apiKey = '4dfa71d4a0129d1bf66cb38d5bc55812';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=${city.value}&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        temperature.value = data['main']['temp'].toString();
        description.value = data['weather'][0]['description'];
        weatherMain.value = data['weather'][0]['main']; // ✅ update main
      } else {
        Get.snackbar('Error', 'Failed to load weather');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchForecast() async {
    final apiKey = '4dfa71d4a0129d1bf66cb38d5bc55812';
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=${city.value}&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List list = data['list'];

        forecast.clear();
        for (var item in list) {
          String dtTxt = item['dt_txt'];
          if (dtTxt.contains('12:00:00')) {
            forecast.add({
              'date': dtTxt,
              'temp': item['main']['temp'],
              'main': item['weather'][0]['main'],
            });
          }
        }
      } else {
        Get.snackbar('Error', 'Failed to load forecast');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void searchCity(String newCity) {
    city.value = newCity;
    fetchWeather();
    fetchForecast();
  }
}
