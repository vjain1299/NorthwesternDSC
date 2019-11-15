import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
List<String> eventNames = ["Event1", "Event2", "Event3", "Event4"];
List<String> eventDescriptions = ["Event Description", "Event Description", "Event Description", "Event Description"];
class BottomSheetWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomSheetState();
}
class BottomSheetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventNames.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(eventNames[index]),
          subtitle: Text(eventDescriptions[index]),
        );
      },
    );
  }
}