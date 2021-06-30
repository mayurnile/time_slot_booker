import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './core/core.dart';
import './di/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(TimeSlotBooker());
}

class TimeSlotBooker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'time Slot Booker',
      theme: TimeSlotBookerTheme.timeSlotBookerThemeData,
      debugShowCheckedModeBanner: false,
      navigatorKey: di.locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
    );
  }
}
