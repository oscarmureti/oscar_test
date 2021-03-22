import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:oscar_interview/main_activity.dart';
import 'package:oscar_interview/models/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        Colors.white); //this change the status bar color to white
    FlutterStatusbarcolor.setNavigationBarColor(kPrimaryColor);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.muliTextTheme(),
      ),
      home: MainActivity(),
    );
  }
}
