import 'package:event_calendar/screens/edit_event.dart';
import 'package:event_calendar/widget/calendar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: TextStyle(
                  fontFamily: GoogleFonts.macondo().fontFamily,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1),
              textScaleFactor: 1.2),
          centerTitle: true,
        ),
        body: const Calendar(),
        floatingActionButton: FloatingActionButton(
            onPressed: (() {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const EditEventScreen())));
              });
            }),
            backgroundColor: Colors.red,
            child: const Icon(Icons.add, color: Colors.white)));
  }
}
