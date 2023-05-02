import 'dart:async';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';

// * Once the onboarding process is completed you will be taken to this screen


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  String light = 'NA';
  String water = 'NA';

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer t) => getAtSignData());
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

  // //  // The magic line that picks up the snack
    var lightKey = await atClient.get(light_key);
    var waterKey = await atClient.get(water_key);
// //  // Yes that is all you need to do!
    setState(() {
    light = lightKey.value.toString();
    water = waterKey.value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    AtClientManager atClientManager = AtClientManager.getInstance();
    AtClient atClient = atClientManager.atClient;
    String currentAtSign = atClient.getCurrentAtSign() ?? '';
    TextEditingController controller = TextEditingController();


        return Scaffold(
      appBar: AppBar(
        title: const Text('What\'s my current @sign?'),
      ),
      body: Center(
        child: Column(children: [
          const Text('Successfully onboarded and navigated to FirstAppScreen'),

          // * Use the AtClientManager instance to get the AtClient
          // * Then use the AtClient to get the current @sign
          Text('Current @sign: ${atClientManager.atClient.getCurrentAtSign()}'),
          Text('Light sensor value: $light'),
          Text('Water sensor value: $water'),
          TextField(
            controller: controller,
            onChanged: (text) {
              getAtSignData();
            },
          ),

        ]),
      ),
    );
  }
}
