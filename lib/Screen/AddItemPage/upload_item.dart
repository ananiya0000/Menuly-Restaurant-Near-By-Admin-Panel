import 'package:e_commerce/Screen/AddItemPage/UploadData/upload_entertainment.dart';
import 'package:e_commerce/Screen/AddItemPage/UploadData/upload_hospital.dart';
import 'package:e_commerce/Screen/AddItemPage/UploadData/upload_hotel.dart';
import 'package:e_commerce/Screen/AddItemPage/UploadData/upload_restaurant.dart';
import 'package:e_commerce/Screen/AddItemPage/UploadData/upload_shop.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class UploadChoice extends StatefulWidget {
  @override
  _UploadChoiceState createState() => _UploadChoiceState();
}

class _UploadChoiceState extends State<UploadChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose to add',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white12,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => UploadRestaurant()));
            },
            leading: Icon(
              Icons.dinner_dining,
              color: Colors.red[800],
            ),
            title: Text('Add a restaurant'),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => UploadCafe()));
          //   },
          //   leading: Icon(
          //     LineariconsFree.coffee_cup,
          //     color: Colors.red[800],
          //   ),
          //   title: Text('Add a cafe'),
          // ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => UploadHotel()));
            },
            leading: Icon(
              Icons.hotel,
              color: Colors.red[800],
            ),
            title: Text('Add a hotel'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => UploadShop()));
            },
            leading: Icon(
              FontAwesome5.shopping_bag,
              color: Colors.red[800],
            ),
            title: Text('Add a shopping'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          UploadEntertainment()));
            },
            leading: Icon(
              FontAwesome.music,
              color: Colors.red[800],
            ),
            title: Text('Add an entertainment'),
          ),

          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => UploadHospital()));
            },
            leading: Icon(
              FontAwesome.hospital,
              color: Colors.red[800],
            ),
            title: Text('Add a hospital'),
          ),
        ],
      ),
    );
  }
}
