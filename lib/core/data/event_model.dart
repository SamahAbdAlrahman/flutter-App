class EventModel {
  static const String collectionName = "events";
  String id;
  String title;
  String description;
  DateTime dateTime;
  String time;
  bool isFavorite;
  String eventName;

  // Constructor
  EventModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.dateTime,
    required this.time,
    this.isFavorite = false,
    required this.eventName
  });

  //
  // تحويل obj إلى صيغة قابلة للإرسال إلى Firestore
  // obj --> json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.microsecondsSinceEpoch,
      'time': time,
      'isFavorite': isFavorite,
      'eventName': eventName,
    };
  }

  // json -> obj
  factory EventModel.fromFireStore(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'] ?? "",
      title: data['title'],
      description: data['description'],
      dateTime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']),
      time: data['time'],
      isFavorite: data['isFavorite'],
      eventName: data['eventName'],
    );
  }
}
