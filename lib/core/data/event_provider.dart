import 'package:flutter/material.dart';

import 'event_model.dart';


class EventProvider with ChangeNotifier {
  List<EventModel> _events = [];

  List<EventModel> get events => _events;

  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();  // لتحديث واجهة المستخدم بعد إضافة الحدث
  }
}
