import 'dart:async';

import 'package:evanston_draft/bottom_sheet.dart';
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
  @override
  Completer<GoogleMapController> controllerCompleter = Completer();
  Widget build(BuildContext context) {
     return GoogleMap(
       initialCameraPosition: CameraPosition(
         bearing: 192.8334901395799,
         target: LatLng(42.0451, 87.6877),
         tilt: 59.440717697143555,
         zoom: 19.151926040649414,
       ),
       onMapCreated: (GoogleMapController _googleMapController) {
         controllerCompleter.complete(_googleMapController);
       },
     );
  }
}