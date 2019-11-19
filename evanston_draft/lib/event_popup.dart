import 'dart:math';

import 'package:evanston_draft/event_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventPopup extends StatelessWidget {
  EventObject event;
  EventPopup(this.event);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      backgroundColor: Colors.white,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: Image(image: NetworkImage(event.imageUrl, scale: 0.5),),
      ),
      content: Container(
        height: 200,
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            Text(
              event.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
                fontStyle: FontStyle.italic
              ),
              textAlign: TextAlign.center,
            ),
            Divider(height: 10,),
            Text(event.host,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Divider(),
            Text(event.startTime,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(event.address,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Divider(),
            Text(event.details,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
            //rowsBuilder(['Host:', 'Date:', 'Time:', 'Address:', 'Details:'], [event.host, event.date, event.startTime, event.address, event.details??'N/A'])
//            ListTile(
//              leading: Text('Host:', style: TextStyle(color: Colors.black)),
//              title: Text(event.host, style: TextStyle(color: Colors.black),),
//            ),
//            ListTile(
//              leading: Text('Date:', style: TextStyle(color: Colors.black)),
//              title: Text(event.date, style: TextStyle(color: Colors.black),),
//            ),
//            ListTile(
//              leading: Text('Time:', style: TextStyle(color: Colors.black)),
//              title: Text(event.startTime, style: TextStyle(color: Colors.black),),
//            ),
//            ListTile(
//              leading: Text('Address:', style: TextStyle(color: Colors.black)),
//              title: Text(event.address, style: TextStyle(color: Colors.black),),
//            ),
//            ListTile(
//              leading: Text('Details:', style: TextStyle(color: Colors.black)),
//              title: Text(event.details == null? 'N/A' : event.details , style: TextStyle(color: Colors.black),),
//            ),
          ],
        )
      )
    );
  }
  Widget rowsBuilder(List<String> labels, List<String> content) {
    List<Row> labelRows = [];
    List<Row> contentRows = [];
    labels.forEach((item) {
      labelRows.add(Row(
        children: <Widget>[
          Container(
            width: 100,
            child: Text(item, style: TextStyle(color: Colors.black), textAlign: TextAlign.left,),
          )
        ],
      ));
    });
    content.forEach((item) {
      contentRows.add(Row(
        children: <Widget>[
          Container(
            width: 150,
            child: Text(item, style: TextStyle(color: Colors.black), textAlign: TextAlign.left,),
          )
        ],
      ));
    });
    return Row(
      children: <Widget>[
        Column(
          children: labelRows,
        ),
        Column(
          children: contentRows,
        ),
      ],
    );
  }
}