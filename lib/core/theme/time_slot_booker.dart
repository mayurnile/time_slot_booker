import 'package:flutter/material.dart';

class TimeSlotBookerTheme {
  //colors
  static const Color PRIMARY_COLOR = Color(0xFF45BFE5);
  static const Color SECONDARY_COLOR = Color(0xFFFFFFFF);
  static const Color BOOKED_SLOT_COLOR = Color(0xFFe54444);
  static const Color FONT_DARK_COLOR = Color(0xFF333333);
  static const Color FONT_LIGHT_COLOR = Color(0XFF9AACB1);

  static ThemeData timeSlotBookerThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: PRIMARY_COLOR,
    accentColor: PRIMARY_COLOR,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: FONT_DARK_COLOR,
      ),
      headline2: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: FONT_DARK_COLOR,
      ),
      headline3: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: FONT_LIGHT_COLOR,
      ),
      headline4: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: FONT_DARK_COLOR,
      ),
      headline5: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: FONT_LIGHT_COLOR,
      ),
      headline6: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: FONT_DARK_COLOR,
      ),
    ),
  );
}
