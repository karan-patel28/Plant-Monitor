import 'package:flutter/material.dart';

class PlantDetailsPage extends StatefulWidget {
  // Variable declaration
  final String? title; // Title of the plant
  final String? subtitle; // Description of the plant
  final String? light; // Light requirements of the plant
  final String? water; // Water requirements of the plant
  final int? slight; // Starting value of light
  final int? elight; // Ending value of light
  final int? swater; // Starting value of water level
  final int? ewater; // Ending value of water level
  final int? stemp; // Starting temperature range
  final int? etemp; // Ending temperature range
  final int? shumid; // Starting humidity level
  final int? ehumid; // Ending humidity level
  final int? smoisture; // Starting moisture level
  final int? emoisture; // Ending moisture level

  // Constructor for class PlantDetailsPage
  const PlantDetailsPage({
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
  _PlantDetailsPageState createState() => _PlantDetailsPageState();
}

class _PlantDetailsPageState extends State<PlantDetailsPage> {
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
                // Title of the plant
                Text(
                  '${widget.title}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                // Description of the plant
                Text(
                  'Description: ${widget.subtitle}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                // Row for displaying the light details
                _buildDetailsRow('Light', '${widget.light}'),
                _buildDetailsRow(
                    'Light Value', '${widget.slight}-${widget.elight}%'),
                // Row for displaying the temperature details
                _buildDetailsRow(
                    'Temperature', '${widget.stemp}-${widget.etemp}°F'),
                // Row for displaying the humidity details
                _buildDetailsRow(
                    'Humidity', '${widget.shumid}-${widget.ehumid}%'),
                // Row for displaying the moisture details
                _buildDetailsRow(
                    'Moisture', '${widget.smoisture}-${widget.emoisture}%'),
                // Row for displaying the water details
                _buildDetailsRow('Water', '${widget.water}'),
                _buildDetailsRow(
                    'Water Level', '${widget.swater}-${widget.ewater}%'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for displaying a details row with a label and value
  Widget _buildDetailsRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label of the detail
        Text(
          '$label:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        // Value of the detail
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
