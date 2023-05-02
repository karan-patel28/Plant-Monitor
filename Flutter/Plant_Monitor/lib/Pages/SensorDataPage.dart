import 'package:flutter/material.dart';
import 'dart:async';
import 'package:at_client_mobile/at_client_mobile.dart';

class SensorDataPage extends StatefulWidget {
  const SensorDataPage({Key? key}) : super(key: key);

  @override
  _SensorDataPage createState() => _SensorDataPage();
}

class _SensorDataPage extends State<SensorDataPage> {
  String light = 'NA';
  String water = 'NA';
  String moisture = 'NA';
  String steam = 'NA';
  double lightvalue=0;
  double watervalue=0;
  double moisturevalue=0;
  double steamvalue=0;
  Timer? timer;
  String huVal = 'NA';

  final int stemp = 60, etemp = 80;
  final int shumidity = 60, ehumidity = 70;
  final int smoist = 20, emoist = 22;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer t) => getAtSignData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> getAtSignData() async {
    AtClientManager atClientManager = AtClientManager.getInstance();
    AtClient atClient = atClientManager.atClient;

    String currentAtSign = atClient.getCurrentAtSign() ?? '';

    String otherAtSign = "@20domestic45";

    var metaData = Metadata()
      ..isPublic = false
      ..isEncrypted = true
      ..namespaceAware = false;

    var light_key = AtKey()
      ..key = "light"
      ..sharedBy = otherAtSign
      ..sharedWith = currentAtSign
      ..metadata = metaData;

    var water_key = AtKey()
      ..key = "water"
      ..sharedBy = otherAtSign
      ..sharedWith = currentAtSign
      ..metadata = metaData;

    var moist_key = AtKey()
      ..key = "moisture"
      ..sharedBy = otherAtSign
      ..sharedWith = currentAtSign
      ..metadata = metaData;

    var steam_key = AtKey()
      ..key = "steam"
      ..sharedBy = otherAtSign
      ..sharedWith = currentAtSign
      ..metadata = metaData;

    var lightKey = await atClient.get(light_key);
    var waterKey = await atClient.get(water_key);
    var moistKey = await atClient.get(moist_key);
    var steamKey = await atClient.get(steam_key);
    

    setState(() {
      light = lightKey.value.toString();
      water = waterKey.value.toString();
      moisture = moistKey.value.toString();
      steam = steamKey.value.toString();

      lightvalue=double.parse(light);
      lightvalue=(100*lightvalue)/4100;
      lightvalue=double.parse(lightvalue.toStringAsFixed(2));

      watervalue=double.parse(water);
      watervalue=(100*watervalue)/2300;
      watervalue=double.parse(watervalue.toStringAsFixed(2));

      moisturevalue=double.parse(moisture);
      moisturevalue=(100*moisturevalue)/2500;
      moisturevalue=double.parse(moisturevalue.toStringAsFixed(2));

      steamvalue=double.parse(steam);
      steamvalue=(100*steamvalue)/3300;
      steamvalue=double.parse(steamvalue.toStringAsFixed(2));
    });
  }

    @override
  void Calculation() {
    if (moisturevalue >= shumidity && moisturevalue <= ehumidity) {
      huVal = 'Humidity level ok.';
    }
    else if (moisturevalue >= etemp) {
      huVal = 'Humidity level high.';
    }
    else if (moisturevalue <= shumidity) {
      huVal = 'Humidity level low.';
    }
  }


  @override
  Widget build(BuildContext context) {
    AtClientManager atClientManager = AtClientManager.getInstance();
    AtClient atClient = atClientManager.atClient;
    String currentAtSign = atClient.getCurrentAtSign() ?? '';
    TextEditingController controller = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sensor Reading',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      getAtSignData();
                    },
                    icon: Icon(Icons.sync),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.lightGreen[100],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Light Sensor Reading: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${lightvalue.toString()}%')

                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Water Level Sensor Reading: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${watervalue.toString()}%')
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Moisture Sensor Reading: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${moisturevalue.toString()}%')
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Steam Sensor Reading: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${steamvalue.toString()}%')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
              ),
          onPressed: () {
            Calculation();
          },
          child: Text('Generate Result', style: TextStyle(color: Colors.black),),
        ),
        SizedBox(height: 16.0),
        Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$huVal'),
        ),
      ),
      ],
    );
  }
}
