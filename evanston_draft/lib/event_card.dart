import 'package:evanston_draft/event_object.dart';
import 'package:evanston_draft/event_popup.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  EventObject event;
  EventCard(this.event);
  @override
  State<StatefulWidget> createState() => EventCardState();
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
        Color(0xfcd2fb):
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EventPopup(event);
              }
            )
          );
        },
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(event.imageUrl),
            ),
            Container(
              margin: EdgeInsets.all(4.0),
              child: Row(
                children: <Widget>[
                  Text(event.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text(event.host, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),),
                  Text(event.startTime, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(event.address, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ListTile(
                    title: Text('More'),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.black,),
                      onPressed: () {
                        print('Tapped');
                        //Add functionality
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}