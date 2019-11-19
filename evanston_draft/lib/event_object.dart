class EventObject {
  final String title;
  final String host;
  final String startTime;
  final String date;
  final int duration;
  final double latitude;
  final double longitude;
  final String address;
  final String imageUrl;
  final String typeOfEvent;
  final int price;
  final String details;
  EventObject([this.title, this.host, this.startTime, this.date, this.latitude, this.longitude, this.address, this.imageUrl = 'some default imageUrl', this.typeOfEvent = 'Academic', this.details, this.price = 0, this.duration = 60]);
}