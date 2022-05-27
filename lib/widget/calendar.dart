import 'package:event_calendar/model/models.dart';
import 'package:event_calendar/util/dimenstions.dart';
import 'package:event_calendar/provider/event_provider.dart';
import 'package:event_calendar/widget/task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    return SfCalendar(
        headerHeight: Dimensions.heightFactor * 50,
        viewHeaderHeight: Dimensions.heightFactor * 50,
        view: CalendarView.month,
        todayHighlightColor: Colors.red,
        initialSelectedDate: DateTime.now(),
        dataSource: EventDataSource(provider.events),
        cellBorderColor: Colors.transparent,
        onTap: (detail) {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.setDate(detail.date!);
          showCupertinoModalBottomSheet(
              context: context, builder: (context) => const TaskWidget());
        },
        selectionDecoration: BoxDecoration(
          color: const Color.fromARGB(62, 0, 0, 0),
          border: Border.all(
              color: Colors.white, width: Dimensions.heightFactor * 2),
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.heightFactor * 5)),
          shape: BoxShape.rectangle,
        ),
        todayTextStyle: TextStyle(
            fontSize: Dimensions.heightFactor * 14,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.roboto().fontFamily),
        viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: TextStyle(
                fontSize: Dimensions.heightFactor * 15,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.roboto().fontFamily)),
        headerStyle: CalendarHeaderStyle(
            textStyle: TextStyle(
                fontSize: Dimensions.heightFactor * 20,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.roboto().fontFamily)));
  }
}
