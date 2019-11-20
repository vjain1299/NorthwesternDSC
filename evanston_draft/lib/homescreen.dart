import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evanston_draft/EventMockData.dart';
import 'package:evanston_draft/bottom_sheet.dart';
import 'package:evanston_draft/bottom_sheet_example.dart';
import 'package:evanston_draft/event_card.dart';
import 'package:evanston_draft/event_object.dart';
import 'package:evanston_draft/event_popup.dart';
import 'package:evanston_draft/filtersheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_bottom_sheet/scrollable_bottom_sheet.dart';
import 'package:scrollable_bottom_sheet/scrollable_controller.dart';
GoogleMap mMap;
GoogleMapController mapController;
String query = '';
class HomeScreen extends StatelessWidget {
  bool _bottomSheetActive = false;
  String _currentState = "minimum";
  String _currentDirection = "up";
  final controller = ScrollableController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evanston',
      theme: ThemeData.dark(),
      home: Scaffold (
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text('DSC'),
              )
            ],
          ),
        ),
        key: GlobalKey(debugLabel: 'HomeScaffold'),
        endDrawer: FilterSheet(),
        bottomSheet: _bottomSheetBuilder(context),
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
            onChanged: (String newText) {
              query = newText;
            },
          ),
        ),
        body:
          HomeScreenBody(),
      ),
    );
  }
  Widget _bottomSheetBuilder(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return ScrollableBottomSheet(
        controller: controller,
        halfHeight: 300.0,
        minimumHeight: 50.0,
        autoPop: true,
        scrollTo: ScrollState.minimum,
        snapAbove: false,
        snapBelow: false,
        callback: (state) {
          if (state == ScrollState.minimum) {
            _currentState = "minimum";
            _currentDirection = "up";
          } else if (state == ScrollState.half) {
            if (_currentState == "minimum") {
              _currentDirection = "up";
            } else {
              _currentDirection = "down";
            }
            _currentState = "half";
          } else {
            _currentState = "full";
            _currentDirection = "down";
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: double.maxFinite),
          child: Column(
            children: <Widget>[
              IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_up),
                    onPressed: () {
                      if (_currentState == "half") {
                        if (_currentDirection == "up") {
                          controller.animateToFull(context);
                        } else {
                          controller.animateToMinimum(context);
                        }
                      } else {
                        controller.animateToHalf(context);
                      }
                    },
                ),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('events').orderBy('title').startAt([query]).endAt([query + '\uf8ff']).getDocuments().asStream(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return LinearProgressIndicator();
                  }
                  return Column(
                      children: List.from(snapshot.data.documents.map((docSnap) {
                        return Container(
                          height: 216,
                          padding: EdgeInsets.all(8.0),
                          child: EventCard(EventObject.fromMap(docSnap.data)),
                        );
                      }
                      )));
                },
              )),
            ],
          )
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
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('events').orderBy('title').startAt([query]).endAt([query + '\uf8ff']).getDocuments().asStream(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        mMap = GoogleMap(
          initialCameraPosition: CameraPosition(
            bearing: 0,
            target: LatLng(42.0534, -87.6737),
            tilt: 30,
            zoom: 15.6,
          ),
          markers: Set<Marker>(),
          onMapCreated: (GoogleMapController _googleMapController) {
            mapController = _googleMapController;
            controllerCompleter.complete(_googleMapController);
          },
        );
        snapshot.data.documents.forEach((docSnap) {
          mMap.markers.add(
            Marker(
              markerId: MarkerId(docSnap.documentID),
              position: LatLng(docSnap.data['latitude']/10000, docSnap.data['longitude']/10000),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EventPopup(EventObject.fromMap(docSnap.data));
                    }
                );
              }
            )
          );
        });
        return mMap;
      },
    );
  }
  
}