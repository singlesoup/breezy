import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    //primarySwatch: Colors.blue,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: Colors.white70,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 96.0,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      headline2: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 60.0,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      headline3: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 48.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
      ),
      headline4: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 34.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline5: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
      ),
      headline6: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.25,
      ),
      caption: TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      overline: TextStyle(
        fontFamily: 'Lato',
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
  );
}
