import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../Model/weather.dart';

class CurrentWeather extends StatefulWidget {
  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Weather>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return weatherBox(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
          margin: const EdgeInsets.all(10.0),
          child: Text(
            "${_weather.temp}°C",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
          )),
      Container(
          margin: const EdgeInsets.all(5.0), child: Text("${_weather.description}")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("Feels:${_weather.feelsLike}°C")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("H:${_weather.high}°C L:${_weather.low}°C")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("Humidity: ${_weather.humidity}%")),
    ]);
  }

  Future<Weather> getCurrentWeather() async {
    Weather weather;
    String city = "boston";
    String apiKey = "0d8ae6eb9028a3df4a6398ca265a589a";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      throw Exception("Failed to get weather data");
    }
  }
}
