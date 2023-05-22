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
          // FutureBuilder widget to handle asynchronous data fetching
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // If data is available, display the weatherBox widget
              return weatherBox(snapshot.data!);
            } else if (snapshot.hasError) {
              // If there is an error, display the error message
              return Text("Error: ${snapshot.error}");
            } else {
              // While waiting for data, display a loading indicator
              return CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(), // Fetching weather data asynchronously
        ),
      ),
    );
  }

  // Function to display weather information
  Widget weatherBox(Weather _weather) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Text(
            "${_weather.temp}°C",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("${_weather.description}"),
        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("Feels:${_weather.feelsLike}°C"),
        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("H:${_weather.high}°C L:${_weather.low}°C"),
        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("Humidity: ${_weather.humidity}%"),
        ),
      ],
    );
  }

  // Function to fetch current weather data from the API
  Future<Weather> getCurrentWeather() async {
    Weather weather; // Weather object to store the data
    String city = "boston";
    String apiKey = "0d8ae6eb9028a3df4a6398ca265a589a";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the API call is successful, parse the response and return the Weather object
      weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      // If there is an error, throw an exception
      throw Exception("Failed to get weather data");
    }
  }
}
