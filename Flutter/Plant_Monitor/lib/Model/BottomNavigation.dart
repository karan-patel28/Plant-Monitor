import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Pages/HomePage.dart';
import '../Pages/PlantDetailsPage.dart';
import '../Pages/SensorDataPage.dart';
import '../Pages/WeatherPage.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  List<Widget> _pages = [
    PlantDetailsPage(),
    CurrentWeather(),
    SensorDataPage(),
  ];

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
                }),
            title: Row(
              children: [
                Icon(
                  Icons.local_florist,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  'Plant Monitor',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            backgroundColor: Colors.lightGreen),
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
