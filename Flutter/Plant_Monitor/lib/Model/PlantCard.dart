import 'package:finalriya/Model/plants.dart';
import 'package:flutter/material.dart';

class PlantListView extends StatelessWidget {
  final List<Plant> plants;

  PlantListView({required this.plants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plants.length,
      itemBuilder: (BuildContext context, int index) {
        final plant = plants[index];
        return Card(
          child: ListTile(
            leading: Image.network(
              plant.image,
              width: 60,
              height: 60,
            ),
            title: Text(plant.name),
            subtitle: Text(plant.desc),
          ),
        );
      },
    );
  }
}