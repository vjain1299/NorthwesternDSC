import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evanston_draft/bottom_sheet.dart';
import 'package:evanston_draft/event_card.dart';
import 'package:evanston_draft/event_object.dart';
import 'package:evanston_draft/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_bottom_sheet/scrollable_bottom_sheet.dart';
import 'package:scrollable_bottom_sheet/scrollable_controller.dart';

class BottomSheetDemo extends StatefulWidget {
  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo> with TickerProviderStateMixin {
  bool _bottomSheetActive = false;
  String _currentState = "initial";
  String _currentDirection = "up";
  final controller = ScrollableController();

  void _showMessage(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('You tapped the floating action button.'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        );
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: null,
      body: Builder(
        builder: (BuildContext context) {
          return Column(children: [
            Expanded(
                child: Center(
                    child: RaisedButton(
                        onPressed: _bottomSheetActive
                            ? null
                            : () {
                          setState(() {
                            //disable button
                            _bottomSheetActive = true;
                          });
                          _showBottomSheet(context);
                        },
                        child: const Text('Show bottom sheet')))),
            Expanded(
                child: Center(
                    child: RaisedButton(
                        onPressed: () {
                          print('touched');
                        },
                        child: const Text('Show bottom sheet')))),
          ]);
        },
      ),
    );
  }

  Widget _bottomSheetBuilder(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Stack(children: [
      ScrollableBottomSheet(
        controller: controller,
        halfHeight: 300.0,
        minimumHeight: 300.0,
        autoPop: false,
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
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('events').orderBy('title').startAt([query]).endAt([query + '\uf8ff']).getDocuments().asStream(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return LinearProgressIndicator();
                }
                return Column(
                    children: List.from(snapshot.data.documents.map((docSnap) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: EventCard(EventObject.fromMap(docSnap.data)),
                      );
                    }
                )));
              },
            ),
                ),
      ),
      Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          height: 50.0,
          child: Material(
            elevation: 15.0,
            child: IconButton(
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
                }),
          ))
    ]);
  }

  _showBottomSheet(BuildContext context) {
    showBottomSheet<void>(context: context, builder: _bottomSheetBuilder).closed.whenComplete(() {
      if (mounted) {
        setState(() {
          // re-enable the button
          _bottomSheetActive = false;
        });
      }
    });
  }
}
