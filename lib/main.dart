import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_app_original/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primaryColor: Colors.red[400],
      ),
      home: LandingPage(),
    );
  }
}
