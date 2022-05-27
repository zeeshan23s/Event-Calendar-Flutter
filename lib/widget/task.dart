import 'package:event_calendar/model/event_data_source.dart';
import 'package:event_calendar/provider/event_provider.dart';
import 'package:event_calendar/screens/view_event.dart';
import 'package:event_calendar/util/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: Dimensions.heightFactor * 300,
                width: Dimensions.widthFactor * 300,
                child: Image.network(
                    "https://pics.freeicons.io/uploads/icons/png/20833676421583230987-512.png")),
            SizedBox(height: Dimensions.heightFactor * 30),
            Text('No Events Found!',
                style: TextStyle(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    color: Colors.white,
                    fontSize: Dimensions.heightFactor * 30,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    return SafeArea(
      child: Material(
        child: SfCalendarTheme(
            data: SfCalendarThemeData(
                headerTextStyle: TextStyle(
                    fontSize: Dimensions.heightFactor * 20,
                    color: Colors.white,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontWeight: FontWeight.bold),
                timeTextStyle: TextStyle(
                    fontSize: Dimensions.heightFactor * 16,
                    color: Colors.white,
                    fontFamily: GoogleFonts.roboto().fontFamily)),
            child: SfCalendar(
              view: CalendarView.timelineDay,
              dataSource: EventDataSource(provider.events),
              initialDisplayDate: provider.selectedDate,
              appointmentBuilder: appointmentBuilder,
              onTap: (details) {
                if (details.appointments == null) return;

                final event = details.appointments!.first;

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewEventScreen(event: event)));
              },
              headerHeight: Dimensions.heightFactor * 40,
              viewHeaderHeight: Dimensions.heightFactor * 40,
              todayHighlightColor: Colors.white,
              selectionDecoration:
                  BoxDecoration(color: Colors.black.withOpacity(0.2)),
            )),
      ),
    );
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;

    return Container(
      margin: EdgeInsets.only(top: Dimensions.heightFactor * 5),
      width: Dimensions.widthFactor * (details.bounds.width),
      height: Dimensions.heightFactor * (details.bounds.height),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(Dimensions.heightFactor * 20)),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            color: Colors.white,
            fontSize: Dimensions.heightFactor * 16,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
