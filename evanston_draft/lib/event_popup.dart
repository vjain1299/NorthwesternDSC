import 'package:evanston_draft/event_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventPopup extends StatelessWidget {
  EventObject event;
  EventPopup(this.event);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(event.title),
      content: Text(event.host),
    );
  }
}