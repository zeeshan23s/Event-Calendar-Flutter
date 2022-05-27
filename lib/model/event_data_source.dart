import 'package:event_calendar/model/event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  List<Event> events = [];

  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) {
    return getEvent(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return getEvent(index).to;
  }

  @override
  String getSubject(int index) {
    return getEvent(index).title;
  }
}
