import 'dart:ui';

import 'package:evanston_draft/event_object.dart';
import 'package:evanston_draft/event_popup.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  EventObject event;
  EventCard(this.event);
  @override
  State<StatefulWidget> createState() => EventCardState(event);
}
class EventCardState extends State<EventCard> {
  EventObject event;
  EventCardState(this.event);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(4.0),
      color: event.typeOfEvent == 'Academic'?
        //Color(0xfcd2fb):
        Colors.greenAccent.withAlpha(50):
          event.typeOfEvent == 'Social'?
          Color(0xccecf7) :
            event.typeOfEvent == 'Music'?
              Color(0xffddb0) :
                event.typeOfEvent == 'Food'?
                  Color(0xc3b2f3) :
                  Colors.white,
      child: InkWell(
        highlightColor: Colors.white,
        onTap: () {
          /* Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EventPopup(event);
              }
            )
          ); */
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text(event.title),
              content: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Hosted by:'),
                    subtitle: Text(event.host),
                  ),
                  ListTile(
                    title: Text('Start Time:'),
                    subtitle: Text(event.startTime),
                  ),
                ],
              ),
            );
          });
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          width: double.maxFinite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: NetworkImage(event.imageUrl),
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(4),
                      width: 300,
                      child: Text(event.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left,),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      width: 300,
                      child: Text(event.host, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16), textAlign: TextAlign.left,),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      width: 300,
                      child: Text(event.startTime, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15), textAlign: TextAlign.left,),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      width: 300,
                      child: Text(event.address, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15), textAlign: TextAlign.left,),
                    )
                    /* ListTile(
                      title: Text('More'),
                      trailing: IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.black,),
                        onPressed: () {
                          print('Tapped');
                          //Add functionality
                        },
                      ),
                    ) */
                  ],
              )
            ],
          ),
        )
      ),
    );
  }
}