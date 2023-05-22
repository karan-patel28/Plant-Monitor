import 'package:flutter/material.dart';
import 'dart:async';
import 'package:at_client_mobile/at_client_mobile.dart';

class SensorDataPage extends StatefulWidget {
  // Variable declaration
  // each variable stats with
  // s = represents start value of variable
  // e = represents end value of variable
  final String? title;
  final String? subtitle;
  final String? light;
  final String? water;
  final int? slight;
  final int? elight;
  final int? swater;
  final int? ewater;
  final int? stemp;
  final int? etemp;
  final int? shumid;
  final int? ehumid;
  final int? smoisture;
  final int? emoisture;

  // Constructor for class SensorDataPage
  const SensorDataPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.light,
    required this.water,
    required this.slight,
    required this.elight,
    required this.swater,
    required this.ewater,
    required this.stemp,
    required this.etemp,
    required this.shumid,
    required this.ehumid,
    required this.smoisture,
    required this.emoisture,
  }) : super(key: key);

  @override
  _SensorDataPage createState() => _SensorDataPage();
}

class _SensorDataPage extends State<SensorDataPage> {
  // Variable declaration
  String light = 'NA';
  String water = 'NA';
  String moisture = 'NA';
  String steam = 'NA';

  String lightResult = 'NA';
  String steamResult = 'NA';
  String waterResult = 'NA';
  String moistureResult = 'NA';

  String lightSensorResult = 'NA';
  String steamSensorResult = 'NA';
  String waterSensorResult = 'NA';
  String moistureSensorResult = 'NA';

  double lightvalue = 0;
  double watervalue = 0;
  double moisturevalue = 0;
  double steamvalue = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // The data is refreshed every 5 seconds on the Flutter app
    Timer.periodic(Duration(seconds: 5), (Timer t) => getAtSignData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Function to fetch data from the ESP32 device
  Future<void> getAtSignData() async {
    AtClientManager atClientManager = AtClientManager.getInstance();
    AtClient atClient = atClientManager.atClient;
    // Get the current AtSign used in the Flutter app
    String currentAtSign = atClient.getCurrentAtSign() ?? '';
    // Get the AtSign used in the ESP32 device
    String otherAtSign = "@20domestic45";

    var metaData = Metadata()
      ..isPublic = false
      ..isEncrypted = true
      ..namespaceAware = false;
    // Fetch the data of the light sensor from the AtKey
    var light_key = AtKey()
      ..key = "light"
      ..sharedBy = otherAtSign
      ..sharedWith = currentAtSign
      ..metadata = metaData;
    // Fetch the data of the water sensor from the AtKey
    var water_key = AtKey()
      ..key = "water"
      ..sharedBy = otherAtSign
      ..sharedWith = currentAtSign
      ..metadata = metaData;
    // Fetch the data of the steam sensor from the AtKey
    var steam_key = AtKey()
      ..key = "steam"
      ..sharedBy = otherAtSign
      ..sharedWith = currentAtSign
      ..metadata = metaData;
    // Fetch the data of the moisture sensor from the AtKey
    var moisture_key = AtKey()
      ..key = "moisture"
      ..sharedBy = otherAtSign
      ..sharedWith = currentAtSign
      ..metadata = metaData;
    // Fetch the value of the light sensor from the AtKey
    var response_light = await atClient.get(light_key);
    // Fetch the value of the water sensor from the AtKey
    var response_water = await atClient.get(water_key);
    // Fetch the value of the steam sensor from the AtKey
    var response_steam = await atClient.get(steam_key);
    // Fetch the value of the moisture sensor from the AtKey
    var response_moisture = await atClient.get(moisture_key);

    setState(() {
      // Store the fetched value of the light sensor in lightResult variable
      lightResult = response_light.value;
      // Store the fetched value of the water sensor in waterResult variable
      waterResult = response_water.value;
      // Store the fetched value of the steam sensor in steamResult variable
      steamResult = response_steam.value;
      // Store the fetched value of the moisture sensor in moistureResult variable
      moistureResult = response_moisture.value;
      // Set the value of lightvalue variable to double of lightResult
      lightvalue = double.parse(lightResult);
      // Set the value of watervalue variable to double of waterResult
      watervalue = double.parse(waterResult);
      // Set the value of moisturevalue variable to double of moistureResult
      moisturevalue = double.parse(moistureResult);
      // Set the value of steamvalue variable to double of steamResult
      steamvalue = double.parse(steamResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Displays the subtitle passed to the widget
            Text(
              widget.subtitle!,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Displays the light sensor reading
            Text('Light Sensor: $lightResult'),
            // Displays the water sensor reading
            Text('Water Sensor: $waterResult'),
            // Displays the moisture sensor reading
            Text('Moisture Sensor: $moistureResult'),
            // Displays the steam sensor reading
            Text('Steam Sensor: $steamResult'),
            SizedBox(height: 20),
            // Displays the calculated light value
            Text('Light Value: $lightvalue'),
            // Displays the calculated water value
            Text('Water Value: $watervalue'),
            // Displays the calculated moisture value
            Text('Moisture Value: $moisturevalue'),
            // Displays the calculated steam value
            Text('Steam Value: $steamvalue'),
          ],
        ),
      ),
    );
  }
}
