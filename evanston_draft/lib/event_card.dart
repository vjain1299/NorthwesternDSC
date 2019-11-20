import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
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
    return
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              event.imageUrl, scale: 0.9,
            ),
            alignment: Alignment(0,0),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Card(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            elevation: 10,
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
                  Container(
                    color: Colors.transparent,
                    height: 200,
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
                              child: AutoSizeText(
                                event.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 30,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                maxFontSize: 30,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              width: 300,
                              child: AutoSizeText(
                                event.host,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 26,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                maxFontSize: 26,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              width: 300,
                              child: AutoSizeText(
                                event.startTime,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                maxFontSize: 24,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              width: 300,
                              child: Text(
                                event.address,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                                maxLines: 1,
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
            )),
      );
  }
}
