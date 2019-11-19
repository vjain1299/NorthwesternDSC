import 'package:evanston_draft/EventMockData.dart';
import 'package:flutter/material.dart';
List<String> appliedFiltersList = [];
List<String> allFiltersList = ['Social', 'Music', 'Food', 'Academic'];
class FilterSheet extends StatefulWidget {
  // The above filters are hardcoded in because this is just a test
  @override
  State<StatefulWidget> createState() {
    return FilterSheetState(appliedFiltersList);
  }
}
class FilterSheetState extends State<FilterSheet> {
  List<String> filters;
  FilterSheetState(this.filters);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: allFiltersList.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(allFiltersList[index]),
              leading: filters.contains(allFiltersList[index])?
              IconButton(
                icon: Icon(
                  Icons.check_box,
                ),
                onPressed: () {
                  filters.remove(allFiltersList[index]);
                  setState(() {});
                },
              ):
              IconButton(
                icon: Icon(
                    Icons.check_box_outline_blank
                ),
                onPressed: () {
                  filters.add(allFiltersList[index]);
                  eventList.clear();
                  for(int i = 0; i < allEvents.length; i++) {
                    if(filters.contains(allEvents[i].typeOfEvent)) {
                      eventList.add(allEvents[i]);
                    }
                  }
                  setState(() {});
                },
              )
          );
        },
      ),
      elevation: 5,
    );
  }
}