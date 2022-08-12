import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Contents/HomeContent/Details/Menu/restaurant_food_menu.dart';
import 'package:e_commerce/Contents/HomeContent/Details/area_contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final restaurantName;
  final restaurantMenu;
  final restaurantType;
  final restaurantImage;
  final userlocationLatitude;
  final userlocationLongitude;
  final restaurantPhone;
  final latitude;
  final longitude;
  final restaurantEmail;
  final restaurantFacebook;
  final restaurantInstagram;

  const RestaurantDetailScreen(
      {Key key,
      this.restaurantName,
      this.restaurantMenu,
      this.restaurantType,
      this.restaurantPhone,
      this.restaurantEmail,
      this.restaurantFacebook,
      this.restaurantInstagram,
      this.restaurantImage,
      this.userlocationLatitude,
      this.userlocationLongitude,
      this.latitude,
      this.longitude});
  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  Future<void> _launchInApp() async {
    var url =
        "https://www.google.com/maps/dir/${widget.userlocationLatitude},${widget.userlocationLongitude}/${widget.latitude},${widget.longitude}/@8.9937498,38.7062355,13z/data=!4m11!4m10!1m1!4e1!1m5!1m1!1s0x164b8f10bc299b27:0xf9ac2c481a9b40d9!2m2!1d38.7625901!2d9.0381429!3e2!5i1";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
        enableDomStorage: true,
        enableJavaScript: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[600],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                floating: false,
                snap: false,
                backgroundColor: Colors.blueGrey,
                pinned: true,
                expandedHeight: 300,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: widget.restaurantImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text('Menu'),
                    ),
                    Tab(
                      child: Text('Info'),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            RestaurantFoodMenu(
              menuList: widget.restaurantMenu,
            ),
            AreaDetails(
              image: widget.restaurantImage,
              menuDoc: widget.restaurantMenu,
              facebook: widget.restaurantFacebook,
              instagram: widget.restaurantInstagram,
              phone: widget.restaurantPhone,
              email: widget.restaurantEmail,
              type: widget.restaurantType,
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: FlatButton.icon(
          icon: Icon(
            FontAwesome.direction,
            color: Colors.white,
          ),
          onPressed: () {
            _launchInApp();
          },
          label: Text(
            'Get direction',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
