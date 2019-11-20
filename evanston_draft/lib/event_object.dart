import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EventObject {
  final String title;
  final String host;
  final String startTime;
  final String date;
  final int duration;
  final int latitude;
  final int longitude;
  final String address;
  final String imageUrl;
  final String typeOfEvent;
  final int price;
  final String details;
  EventObject([this.title, this.host, this.startTime, this.date, this.latitude, this.longitude, this.address, this.imageUrl = 'some default imageUrl', this.typeOfEvent = 'Academic', this.details, this.price = 0, this.duration = 60]);
  static EventObject fromMap(Map<String, Object> input) {
    Timestamp time = input['startTime'];
    DateTime now = time.toDate();
    EventObject event = EventObject(
      input['title'],
      input['host'],
      DateFormat("h:mm a, EEEE, MMMM d, y").format(now),
      input['date'],
      input['latitude'],
      input['longitude'],
      input['address'],
      input['imageUrl'],
      input['typeOfEvent'],
      input['details'],
      input['price'],
      input['duration'],
    );
    return event;
  }
}