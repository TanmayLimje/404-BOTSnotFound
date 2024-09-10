import 'package:flutter/material.dart';
import 'package:sih/MouseTracking/test2.dart';

import 'package:sih/Others/mobile.dart';

import 'package:sih/Others/pc.dart';

import 'package:sih/MouseTracking/test.dart';
import 'package:sih/Screens/active_captcha.dart';
import 'package:sih/Screens/loadining_screen.dart';
import 'package:sih/Screens/page1.dart';
import 'package:sih/Screens/page3.dart';
import 'package:sih/Screens/passive_captcha.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uidai.gov.in',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: kIsWeb ? const PCMainWidget() : const MobileMainWidget(),
      home: HomePage(),
    );
  }
}

class PCMainWidget extends StatelessWidget {
  const PCMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Widgets for PC
    return CaptchaDemo();
  }
}

class MobileMainWidget extends StatelessWidget {
  const MobileMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Widgets for mobile
    return ScrollTouchCoordinates();
  }
}


// [m(92,267)][m(91,265)][m(91,264)][m(91,263)][m(91,262)][m(90,260)][m(89,259)][m(89,258)][m(88,257)][m(88,256)][m(87,254)][m(86,254)][m(86,253)][m(85,252)][m(85,251)][c(l)]", 
//"mousemove_times": "206571858,206571873,206571890,206571906,206571922,206571940,206571957,206571973,206571990,206572007,206572023,206572040,206572057,206572073,206572091,206572107,206572123,206572140,206572157,206572173,206572190,206572208,206572223,206572239,206572256,206572274,206572295,206572307,206572324,206572355,206572