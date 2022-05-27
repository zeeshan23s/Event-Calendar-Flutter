import 'package:event_calendar/model/event_model.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  static final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);

    notifyListeners();
  }

  void editEvent(Event oldEvent, Event newEvent) {
    _events.remove(oldEvent);
    _events.add(newEvent);

    notifyListeners();
  }
}
