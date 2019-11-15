class EventObject {
  final title;
  final host;
  final startTime;
  final duration;
  final latitude;
  final longitude;
  final address;
  final imageUrl;
  final typeOfEvent;
  final price;
  EventObject([this.title, this.host, this.startTime, this.latitude, this.longitude, this.address, this.imageUrl = 'some default imageUrl', this.typeOfEvent = 'Academic', this.price = 0.0, this.duration = 60]);
}