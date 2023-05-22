import 'package:flutter/material.dart';
import '../Data/PlantData.dart';
import '../Model/BottomNavigation.dart';
import 'PlantDetailsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Function called when a card is tapped.
  void _onCardTap(
    String title,
    String subtitle,
    String light,
    String water,
    int slight,
    int elight,
    int swater,
    int ewater,
    int stemp,
    int etemp,
    int shumid,
    int ehumid,
    int smoisture,
    int emoisture,
  ) {
    // Navigate to the BottomNavigationPage with the selected plant data.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigationPage(
          title: title,
          subtitle: subtitle,
          light: light,
          water: water,
          slight: slight,
          elight: elight,
          swater: swater,
          ewater: ewater,
          stemp: stemp,
          etemp: etemp,
          shumid: shumid,
          ehumid: ehumid,
          smoisture: smoisture,
          emoisture: emoisture,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text(
            'Plant Monitor',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightGreen,
        ),
        body: ListView.builder(
          itemCount: plantNames.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              // Call the _onCardTap function when a card is tapped.
              onTap: () => _onCardTap(
                plantNames[index],
                descriptions[index],
                light[index],
                water[index],
                startlightValue[index],
                endlightValue[index],
                startWater[index],
                endWater[index],
                startTemperatures[index],
                endTemperatures[index],
                startHumidity[index],
                endHumidity[index],
                startmoisture[index],
                endmoisture[index],
              ),
              child: Card(
                child: ListTile(
                  title: Text(plantNames[index]),
                  subtitle: Text(descriptions[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
