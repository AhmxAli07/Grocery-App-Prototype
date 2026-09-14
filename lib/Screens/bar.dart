import 'package:prototype/Extra/extra.dart';
import 'package:prototype/Extra/fav.dart';
import 'package:prototype/Screens/Bar/account.dart';

import 'package:prototype/Screens/Bar/home.dart';
import 'package:prototype/Screens/Bar/search.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int _selectedindex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  var widgetsoption = [
    GroceryHome(),
    ExploreScreen(),
    CartScreen(),
    FavoritesScreen(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _selectedindex,
        height: 60.0,
        items: const <Widget>[
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 13),
                child: Icon(Icons.house, size: 30, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  '    Home    ',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Icon(Icons.search, size: 30, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  ' Search  ',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Icon(Icons.shopping_cart, size: 30, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  '    Cart    ',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Icon(
                  Icons.favorite_border_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Favourite',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Icon(Icons.person, size: 30, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Account',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
        color: const Color.fromARGB(255, 40, 40, 40),
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: _onItemTapped,
        letIndexChange: (index) => true,
      ),
      body: widgetsoption.elementAt(_selectedindex),
    );
  }
}
