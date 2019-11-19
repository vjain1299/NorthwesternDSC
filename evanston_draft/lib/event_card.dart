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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 10,
        color: event.typeOfEvent == 'Academic'
            ? Color.fromRGBO(12, 31, 35, 1.0)
            : event.typeOfEvent == 'Social'
                ? Color(0xccecf7)
                : event.typeOfEvent == 'Music'
                    ? Color(0xffddb0)
                    : event.typeOfEvent == 'Food'
                        ? Color(0xc3b2f3)
                        : Colors.black,
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return EventPopup(event);
                });
          },
          child: Stack(
            children: <Widget>[
              Image(
                image: NetworkImage(event.imageUrl, scale: 0.9),
                width: double.maxFinite,
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                width: double.maxFinite,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(4),
                          width: 300,
                          child: Text(
                            event.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 30,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          width: 300,
                          child: Text(
                            event.host,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 26,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          width: 300,
                          child: Text(
                            event.startTime,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          width: 300,
                          child: Text(
                            event.address,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
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
              ),
            ], /* InkWell(
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
            return EventPopup(event);
          });
        }, */
          ),
        ));
  }
}
