import 'package:flutter/material.dart';

class PlantDetailsPage extends StatelessWidget {
  final int stemp = 60, etemp = 80;
  final int shumidity = 60, ehumidity = 70;
  final int smoist = 20, emoist = 22;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Corn',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Description: Corn is a cereal crop that is widely grown around the world for food and animal feed.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _buildDetailsRow('Temperature', '$stemp-$etemp°F'),
                _buildDetailsRow('Humidity', '$shumidity-$ehumidity%'),
                _buildDetailsRow('Moisture', '$smoist-$emoist%'),
                _buildDetailsRow('Water Level', 'Keep soil moist, but not waterlogged'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
