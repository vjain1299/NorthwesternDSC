import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evanston_draft/EventMockData.dart';
import 'package:evanston_draft/event_card.dart';
import 'package:evanston_draft/event_object.dart';
import 'package:evanston_draft/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BottomSheetWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomSheetState();
}
class BottomSheetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('events').orderBy('title').startAt([query]).endAt([query + '\uf8ff']).getDocuments().asStream(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          itemCount: snapshot.data.documents.length * 2,
          itemBuilder: (context, index) {
            if(index % 2 == 1) {
              return Divider();
            }
            int newIndex = index >> 1;
            DocumentSnapshot eventData = snapshot.data.documents[newIndex];
            return EventCard(EventObject.fromMap(eventData.data));
          },
        );
      },
    );
  }

}