import 'package:event_calendar/model/event_model.dart';
import 'package:event_calendar/provider/event_provider.dart';
import 'package:event_calendar/screens/edit_event.dart';
import 'package:event_calendar/util/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewEventScreen extends StatelessWidget {
  final Event event;
  const ViewEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close, size: Dimensions.heightFactor * 24),
              onPressed: () => Navigator.of(context).pop()),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => EditEventScreen(event: event)));
                },
                icon: Icon(
                  Icons.edit,
                  size: Dimensions.heightFactor * 24,
                )),
            IconButton(
                onPressed: () {
                  final provider =
                      Provider.of<EventProvider>(context, listen: false);
                  provider.deleteEvent((event));
                },
                icon: Icon(Icons.delete, size: Dimensions.heightFactor * 24))
          ]),
      body: Container(
        padding: EdgeInsets.all(Dimensions.heightFactor * 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Form",
              style: TextStyle(
                  fontSize: Dimensions.heightFactor * 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  letterSpacing: 1),
            ),
            Text(
              (event.from).toString(),
              style: TextStyle(
                  fontSize: Dimensions.heightFactor * 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  letterSpacing: 1),
            )
          ]),
          SizedBox(height: Dimensions.heightFactor * 5),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("To",
                style: TextStyle(
                    fontSize: Dimensions.heightFactor * 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    letterSpacing: 1)),
            Text(
              (event.to).toString(),
              style: TextStyle(
                  fontSize: Dimensions.heightFactor * 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  letterSpacing: 1),
            )
          ]),
          SizedBox(height: Dimensions.heightFactor * 20),
          Text("Title: ${event.title}",
              style: TextStyle(
                  fontSize: Dimensions.heightFactor * 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  letterSpacing: 1)),
          SizedBox(height: Dimensions.heightFactor * 20),
          Text("Description:",
              style: TextStyle(
                  fontSize: Dimensions.heightFactor * 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  letterSpacing: 1)),
          SizedBox(height: Dimensions.heightFactor * 5),
          Text(event.description,
              style: TextStyle(
                  fontSize: Dimensions.heightFactor * 16,
                  fontWeight: FontWeight.w200,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  letterSpacing: 1))
        ]),
      ),
    );
  }
}
