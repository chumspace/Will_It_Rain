import 'package:flutter/material.dart';
import 'package:will_it_rain/model/weather_model.dart';
import 'package:will_it_rain/services/weather_api_client.dart';
import 'package:will_it_rain/view/additional_information.dart';
import 'package:will_it_rain/view/present_weather.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather("28.53834", "-81.37924");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...rest of the code...

      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (data != null) {
              // Check if data is not null
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  presentWeather(
                    Icons.wb_sunny_rounded,
                    "${data!.temp}",
                    "${data!.cityName}",
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Color(0xdd212121),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  additionalInformation(
                    "${data!.wind}",
                    "${data!.humidity}",
                    "${data!.pressure}",
                    "${data!.feels_like}",
                  ),
                ],
              );
            } else {
              // Handle the case when data is null
              return Text('Data is null');
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
