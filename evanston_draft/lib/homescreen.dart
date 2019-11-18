import 'dart:async';

import 'package:evanston_draft/EventMockData.dart';
import 'package:evanston_draft/bottom_sheet.dart';
import 'package:evanston_draft/event_object.dart';
import 'package:evanston_draft/event_popup.dart';
import 'package:evanston_draft/filtersheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evanston',
      theme: ThemeData.dark(),
      home: Scaffold (
        key: GlobalKey(debugLabel: 'HomeScaffold'),
        endDrawer: FilterSheet(),
        appBar: AppBar(
          actions: <Widget>[
            Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(
                    Icons.filter_list,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            )
          ],
          title: TextField(
            cursorWidth: 2,
            cursorColor: Colors.white,

            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            decoration: InputDecoration.collapsed(
                hintText: 'Search Events',
                hintStyle: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
            ),
          ),
        ),
        body:
          HomeScreenBody(),
        bottomNavigationBar:
            Builder(builder: (context) {
              return ListTile(
                title: IconButton(
                  icon: Icon(Icons.keyboard_arrow_up),
                  onPressed: () {
                    Scaffold.of(context).showBottomSheet((context) {
                      return BottomSheetWidget();
                    });
                  },
                ),
              );
            },
          )
        //bottomSheet:
          //BottomSheetWidget(),
      ),
    );
  }
}
class HomeScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenBodyState();
}
class HomeScreenBodyState extends State<HomeScreenBody> {
  Completer<GoogleMapController> controllerCompleter = Completer();
  @override
  Widget build(BuildContext context) {
    Set<Marker> eventMarkers = Set();
    for(int i = 0; i < eventList.length; i++) {
      EventObject event = eventList[i];
      eventMarkers.add(
          Marker(
            markerId: MarkerId(event.title),
            position: LatLng(event.latitude, event.longitude),
            onTap: () {
              showDialog(context: context, builder: (context) {
                return EventPopup(event);
              },);
            }
          )
      );
    }
     return GoogleMap(
       initialCameraPosition: CameraPosition(
         bearing: 0,
         target: LatLng(42.0534, -87.6737),
         tilt: 30,
         zoom: 15.6,
       ),
       onMapCreated: (GoogleMapController _googleMapController) {
         controllerCompleter.complete(_googleMapController);
       },
       markers: eventMarkers,
     );
  }
}