import 'package:flutter/material.dart';
import 'package:flutter_application_1/weather/pages/search_page.dart';
import 'package:provider/provider.dart';

import '../models/weather_model.dart';
import '../providers/weather_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateUi() {
    setState(() {});
  }

  List<String> s = [
    'Amman',
    'Karak',
  ];

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(
                  updateUi: updateUi,
                );
              }));
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        title: Text('Weather App'),
      ),
      body: Provider.of<WeatherProvider>(context).weatherData == null
          ? Center(
              child: Stack(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://arabhardware.net/wp-content/uploads/2021/05/%D9%85%D8%AA%D8%A7%D8%A8%D8%B9%D8%A9-%D8%A7%D9%84%D8%B7%D9%82%D8%B3-%D9%81%D9%8A-%D8%A7%D9%84%D9%85%D8%AF%D9%86.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'there is no weather start',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        Text(
                          'searching now 🔍',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  weatherData!.getThemeColor(),
                  weatherData!.getThemeColor()[300]!,
                  weatherData!.getThemeColor()[100]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    Provider.of<WeatherProvider>(context).cityName!,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weatherData!.getImage()),
                      Text(
                        weatherData!.temp.toInt().toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  //   for (int i = 0; i < s.length; i++)
                  //     TextButton(onPressed:  (data) {
                  //   hasync {

                  //   WeatherService service = WeatherService();

                  //   WeatherModel? weather =
                  //       await service.getWeather(cityName: s[i]);

                  //   Provider.of<WeatherProvider>(context, listen: false)
                  //       .weatherData = weather;
                  //   Provider.of<WeatherProvider>(context, listen: false)
                  //       .cityName = s[i];

                  //   Navigator.pop(context);
                  // }, child: Text(s[i])),
                  // for (int i = 0; i < s.length; i++)
                  //   TextButton(onPressed: () {}, child: Text(s[i])),
                  Spacer(),
                  Text(
                    weatherData!.weatherStateName,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                      Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                    ],
                  ),
                  Spacer(
                    flex: 5,
                  ),
                ],
              ),
            ),
    );
  }
}
