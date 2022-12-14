import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:e_commerce/Contents/EventsContent/EventDetail/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:ussd/ussd.dart';

import '../../../main.dart';

class EventDetailScreen extends StatefulWidget {
  final ticketPrice;
  final ticketDate;
  final ticketAvailable;
  final ticketName;
  final ticketDescription;
  final ticketImage;

  const EventDetailScreen(
      {Key key,
      this.ticketPrice,
      this.ticketDescription,
      this.ticketImage,
      this.ticketName,
      this.ticketDate,
      this.ticketAvailable});
  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    Event event = Event(
      title: widget.ticketName,
      startDate: widget.ticketDate,
      endDate: widget.ticketDate,
      allDay: false,
    );
    void scheduleAlarm() async {
      DateTime scheduledNotificationDateTime = DateTime.now();
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'alarm_notif',
        'alarm_notif',
        'Channel for Alarm notification',
        icon: 'ic_launcher',
        //  sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
        largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
      );

      var iOSPlatformChannelSpecifics = IOSNotificationDetails(
          //   sound: 'a_long_cold_sting.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true);
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.schedule(
          0,
          'Office',
          'Good morning!',
          scheduledNotificationDateTime,
          platformChannelSpecifics);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              var list = List<PopupMenuEntry<Object>>();
              list.add(PopupMenuItem(
                child: FlatButton.icon(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    label: Text('Add to calendar'),
                    onPressed: () {
                      Navigator.pop(context);
                      Add2Calendar.addEvent2Cal(event).then((success) {
                        scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
                            content: Text(success ? 'Success' : 'Error')));
                      });
                    }),
              ));
              // list.add(PopupMenuItem(
              //   child: FlatButton(
              //     child: Text('Schedule'),
              //     onPressed: () {
              //       scheduleAlarm();
              //     },
              //   ),
              // ));
              // list.add(PopupMenuDivider(
              //   height: 10,
              // ));
              list.add(PopupMenuItem(
                child: FlatButton.icon(
                    icon: Icon(
                      Entypo.ticket,
                      color: Colors.green,
                    ),
                    label: Text('Tickets available'),
                    onPressed: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Wrap(
                                children: [
                                  ListTile(
                                      title: Text('Tickets available at',
                                          style: TextStyle(
                                              color: Colors.blueGrey[700]))),
                                  ListTile(
                                    title: Text(widget.ticketAvailable,
                                        style: TextStyle(
                                            color: Colors.blueGrey[700])),
                                  )
                                ],
                              ),
                              height: 150,
                            );
                          });
                    }),
              ));
              return list;
            },
          ),
        ],
        backgroundColor: Colors.white24,
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.blue,
      //   height: 50,
      //   child: FlatButton.icon(
      //     icon: Icon(
      //       Icons.attach_money,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       showDialog<String>(
      //           context: context,
      //           builder: (BuildContext context) => AlertDialog(
      //                 title: Text('Buy ticket?'),
      //                 content: const Text('Do you want to buy this ticket?'),
      //                 actions: [
      //                   FlatButton(
      //                       onPressed: () {
      //                         Navigator.pop(context);
      //                       },
      //                       child: Text('Cancel')),
      //                   FlatButton(
      //                     onPressed: () {
      //                       Ussd.runUssd(
      //                           "*806*0907268733*${widget.ticketPrice}#");
      //                     },
      //                     child: Text('Buy now'),
      //                   )
      //                 ],
      //               ));
      //     },
      //     label: Text('Buy Ticket',
      //         style: TextStyle(
      //           color: Colors.white,
      //         )),
      //   ),
      // ),
      body: EventDetail(
        eventDetail: widget.ticketDescription,
        eventPicture: widget.ticketImage,
        eventPrice: widget.ticketPrice,
        eventDate: widget.ticketDate,
        eventName: widget.ticketName,
      ),
    );
  }
}
