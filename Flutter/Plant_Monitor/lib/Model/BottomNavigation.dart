import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Pages/HomePage.dart';
import '../Pages/PlantDetailsPage.dart';
import '../Pages/SensorDataPage.dart';
import '../Pages/WeatherPage.dart';

/// The main page with a bottom navigation bar.
class BottomNavigationPage extends StatefulWidget {
  /// The title of the plant.
  final String? title;

  /// The subtitle of the plant.
  final String? subtitle;

  /// The light requirements of the plant.
  final String? light;

  /// The water requirements of the plant.
  final String? water;

  /// The start value of the light requirements.
  final int? slight;

  /// The end value of the light requirements.
  final int? elight;

  /// The start value of the water requirements.
  final int? swater;

  /// The end value of the water requirements.
  final int? ewater;

  /// The start value of the temperature requirements.
  final int? stemp;

  /// The end value of the temperature requirements.
  final int? etemp;

  /// The start value of the humidity requirements.
  final int? shumid;

  /// The end value of the humidity requirements.
  final int? ehumid;

  /// The start value of the moisture requirements.
  final int? smoisture;

  /// The end value of the moisture requirements.
  final int? emoisture;

  /// Constructor for class BottomNavigationPage
  const BottomNavigationPage({
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
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    // Initialize the list of pages for the bottom navigation
    _pages = [
      PlantDetailsPage(
        title: widget.title,
        subtitle: widget.subtitle,
        light: widget.light,
        water: widget.water,
        slight: widget.slight,
        elight: widget.elight,
        swater: widget.swater,
        ewater: widget.ewater,
        stemp: widget.stemp,
        etemp: widget.etemp,
        shumid: widget.shumid,
        ehumid: widget.ehumid,
        smoisture: widget.smoisture,
        emoisture: widget.emoisture,
      ),
      CurrentWeather(),
      SensorDataPage(
        title: widget.title,
        subtitle: widget.subtitle,
        light: widget.light,
        water: widget.water,
        slight: widget.slight,
        elight: widget.elight,
        swater: widget.swater,
        ewater: widget.ewater,
        stemp: widget.stemp,
        etemp: widget.etemp,
        shumid: widget.shumid,
        ehumid: widget.ehumid,
        smoisture: widget.smoisture,
        emoisture: widget.emoisture,
      ),
    ];
  }

  /// Handles the request for page change by the user.
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          title: Row(
            children: [
              Text(
                'Plant Monitor',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.lightGreen,
        ),
        body: PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: GNav(
          gap: 3,
          backgroundColor: Colors.lightGreen,
          padding: EdgeInsets.all(16),
          onTabChange: _onTabChange,
          selectedIndex: _selectedIndex,
          tabs: const [
            GButton(
              icon: Icons.lightbulb_rounded,
              text: 'Ideal',
            ),
            GButton(
              icon: Icons.sunny,
              text: 'Weather',
            ),
            GButton(
              icon: Icons.query_stats_outlined,
              text: 'Stats',
            )
          ],
        ),
      ),
    );
  }
}
