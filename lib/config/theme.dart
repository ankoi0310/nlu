import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nlu/constant/constants.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: backgroundColorLight,
  fontFamily: 'Muli',
  appBarTheme: appBarLightTheme,
  textTheme: lightTextTheme,
  shadowColor: shadowColorLight,
  brightness: Brightness.light,
  iconTheme: const IconThemeData(color: Colors.black),
  inputDecorationTheme: inputDecorationTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: backgroundColorDark,
  fontFamily: 'Muli',
  appBarTheme: appBarDarkTheme,
  textTheme: darkTextTheme,
  shadowColor: shadowColorDark,
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(color: Colors.white),
  inputDecorationTheme: inputDecorationTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

TextTheme lightTextTheme = const TextTheme(
  headlineMedium: TextStyle(color: Colors.black),
);

TextTheme darkTextTheme = const TextTheme(
  headlineMedium: TextStyle(color: Colors.white),
);

AppBarTheme appBarLightTheme = const AppBarTheme(
  color: backgroundColorLight,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.black),
  systemOverlayStyle: SystemUiOverlayStyle.light,
  titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  toolbarTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  centerTitle: true,
);

AppBarTheme appBarDarkTheme = const AppBarTheme(
  color: backgroundColorDark,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.white),
  systemOverlayStyle: SystemUiOverlayStyle.dark,
  titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  toolbarTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  centerTitle: true,
);

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: const Color(0xFFDEE3F2).withOpacity(0.5),
  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
  enabledBorder: outlineInputBorder,
  focusedBorder: outlineInputBorder,
  border: outlineInputBorder,
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: Color(0xFFDEE3F2), width: 1.5),
);
