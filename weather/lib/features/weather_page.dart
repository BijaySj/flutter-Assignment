import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'weather_controller.dart';

class WeatherPage extends StatelessWidget {
  final WeatherController controller = Get.put(WeatherController());
  final TextEditingController cityController = TextEditingController();

  WeatherPage({super.key});

  String getWeatherIcon(String main) {
    switch (main.toLowerCase()) {
      case 'rain':
        return '🌧️';
      case 'clouds':
        return '☁️';
      case 'clear':
        return '☀️';
      case 'snow':
        return '❄️';
      case 'thunderstorm':
        return '⛈️';
      default:
        return '🌈';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Left side: Current weather + search
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: cityController,
                      decoration: InputDecoration(
                        hintText: 'Enter city name',
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (cityController.text.trim().isNotEmpty) {
                              controller.searchCity(cityController.text.trim());
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Obx(() {
                      return controller.temperature.value == ''
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getWeatherIcon(controller.weatherMain.value),
                                  style: const TextStyle(fontSize: 60),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  controller.city.value,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${controller.temperature}°C',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  controller
                                          .description
                                          .value
                                          .capitalizeFirst ??
                                      '',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            );
                    }),
                  ],
                ),
              ),
            ),

            // Right side: 7-day forecast
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '7-Day Forecast',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Obx(() {
                        return controller.forecast.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: controller.forecast.length > 7
                                    ? 7
                                    : controller.forecast.length,
                                itemBuilder: (context, index) {
                                  final item = controller.forecast[index];
                                  final date = DateFormat(
                                    'EEE, MMM d',
                                  ).format(DateTime.parse(item['date']));
                                  final icon = getWeatherIcon(item['main']);
                                  final temp = item['temp'].round().toString();

                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    child: ListTile(
                                      leading: Text(
                                        icon,
                                        style: const TextStyle(fontSize: 28),
                                      ),
                                      title: Text(date),
                                      trailing: Text('$temp°C'),
                                    ),
                                  );
                                },
                              );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
