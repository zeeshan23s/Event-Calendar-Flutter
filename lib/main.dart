import 'package:event_calendar/provider/event_provider.dart';
import 'package:event_calendar/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Event Calendar App';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => EventProvider(),
          )
        ],
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: _title,
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.dark,
            home: const HomeScreen(title: _title)));
  }
}
