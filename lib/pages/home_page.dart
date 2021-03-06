import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecogoals/pages/real_home_page.dart';
import 'package:ecogoals/pages/scan_data_page.dart';
import 'package:ecogoals/pages/scan_page.dart';
import 'package:ecogoals/screens/with_arkit_screen.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  var _pageOptions = [
    Stats(),
    ScanDataPage(),
    WithARkitScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _pageOptions,
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true, // use this to remove appBar's elevation
          itemCornerRadius: 20,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.sort),
              title: Text('Scan'),
              activeColor: Colors.orange,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.sort),
              title: Text('Visualization'),
              activeColor: Colors.orange,
            )
          ],
        ));
  }
}
