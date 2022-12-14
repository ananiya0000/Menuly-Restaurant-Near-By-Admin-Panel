import 'package:e_commerce/Contents/EventsContent/event_content.dart';
import 'package:e_commerce/Screen/EventPage/event_add.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Events',
      //     style: TextStyle(color: Colors.blue),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.white24,
      // ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => EventAdd()));
          },
          child: Icon(Icons.add, color: Colors.white)),
      body: EventContent(),
    );
  }
}
