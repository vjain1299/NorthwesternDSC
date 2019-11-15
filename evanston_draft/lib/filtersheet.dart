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
  var filters;
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