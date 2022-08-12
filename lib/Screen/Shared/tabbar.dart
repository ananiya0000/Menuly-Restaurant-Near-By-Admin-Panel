import 'package:e_commerce/Contents/HomeContent/HomeList/Entertainment/entertainment.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hospitals/hospital.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/hotel.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Restaurant/restaurant.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Shopping/shopping.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  @override
  Widget build(BuildContext context) {
    final tabPages = <Widget>[
      RestaurantMenu(),
      //  CafeMenu(),
      Hotel(),
      Shopping(),
      Entertainment(),
      Hospital(),
    ];
    final tabIcon = <Tab>[
      Tab(
        icon: Icon(
          Icons.dinner_dining,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Restaurants',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),
      // Tab(
      //   icon: Icon(
      //     LineariconsFree.coffee_cup,
      //     color: Colors.orangeAccent[700],
      //   ),
      //   child: Text(
      //     'Cafes',
      //     style: TextStyle(color: Colors.orangeAccent[700]),
      //   ),
      // ),
      Tab(
        icon: Icon(
          Icons.hotel,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Hotels',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),

      Tab(
        icon: Icon(
          Icons.shopping_bag,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Shopping',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),

      Tab(
        icon: Icon(
          FontAwesome.gamepad,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Entertainment',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),
      Tab(
        icon: Icon(
          FontAwesome.hospital,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Hospital',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),
    ];
    return DefaultTabController(
      length: tabIcon.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            'eYelp',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.amber,
            isScrollable: true,
            tabs: tabIcon,
          ),
        ),
        body: TabBarView(children: tabPages),
      ),
    );
  }
}
