// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import '../services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  SearchPage({this.updateUi});
  VoidCallback? updateUi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
      ),
      body: Stack(
        children: [
          Image.network(
            'https://images.pexels.com/photos/209831/pexels-photo-209831.jpeg?auto=compress&cs=tinysrgb&w=600',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (data) {
                  cityName = data;
                },
                onSubmitted: (data) async {
                  cityName = data;

                  WeatherService service = WeatherService();

                  WeatherModel? weather =
                      await service.getWeather(cityName: cityName!);

                  Provider.of<WeatherProvider>(context, listen: false)
                      .weatherData = weather;
                  Provider.of<WeatherProvider>(context, listen: false)
                      .cityName = cityName;

                  Navigator.pop(context);
                },
                decoration: InputDecoration(
                  focusColor: Colors.green,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  label: Text(
                    'search',
                    style: TextStyle(color: Colors.black),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () async {
                        WeatherService service = WeatherService();

                        WeatherModel? weather =
                            await service.getWeather(cityName: cityName!);

                        Provider.of<WeatherProvider>(context, listen: false)
                            .weatherData = weather;
                        Provider.of<WeatherProvider>(context, listen: false)
                            .cityName = cityName;

                        Navigator.pop(context);
                      },
                      child: Icon(Icons.search, color: Colors.black)),
                  border: OutlineInputBorder(),
                  hintText: 'Enter a city',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
