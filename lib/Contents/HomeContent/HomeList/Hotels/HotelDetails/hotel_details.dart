import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/HotelMenu/hotel_contact.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/HotelMenu/hotel_room.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetails extends StatefulWidget {
  final name;
  final phone;
  final instagram;
  final image;
  final facebook;
  final room;
  final latitude;
  final userlocationLatitude;
  final userlocationLongitude;
  final longitude;
  final info;
  final email;

  const HotelDetails(
      {Key key,
      this.name,
      this.phone,
      this.instagram,
      this.facebook,
      this.room,
      this.latitude,
      this.longitude,
      this.email,
      this.userlocationLatitude,
      this.userlocationLongitude,
      this.image,
      this.info})
      : super(key: key);
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
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
          physics: NeverScrollableScrollPhysics(),
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
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                // flexibleSpace: FlexibleSpaceBar(
                //   background: SizedBox(
                //     height: 150,
                //     child: CachedNetworkImage(
                //       imageUrl: widget.image,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                // bottom: TabBar(
                //   tabs: [
                //     Tab(
                //       child: Text('Menu'),
                //     ),
                //     Tab(
                //       child: Text('Info'),
                //     ),
                //   ],
                // ),
              ),
            ];
          },
          body: HotelContact(
            facebook: widget.facebook,
            instagram: widget.instagram,
            phone: widget.phone,
            email: widget.email,
            info: widget.info,
          ),
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

//   ListView(
//     children: [
//       /* Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.grey[300]),
//         child: FlatButton.icon(
//           icon: Icon(Icons.call),
//           label: Text('Call'),
//           onPressed: () {},
//         ),
//       ),
//       Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.grey[300]),
//         child: FlatButton.icon(
//           icon: Icon(Icons.message),
//           label: Text('Message'),
//           onPressed: () {},
//         ),
//       ),
//       Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.grey[300]),
//         child: FlatButton.icon(
//           icon: Icon(Icons.report_rounded),
//           label: Text('Report'),
//           onPressed: () {},
//         ),
//       ),
//     ],
// ),*/
//     ],
//   )
