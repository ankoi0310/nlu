import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFEEF1F8),
  fontFamily: 'Muli',
  appBarTheme: appBarTheme,
  textTheme: textTheme,
  iconTheme: const IconThemeData(color: Color(0xFF8B8B8B)),
  inputDecorationTheme: inputDecorationTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: Color(0xFFDEE3F2), width: 1.5),
);

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: const Color(0xFFDEE3F2).withOpacity(0.5),
  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
  enabledBorder: outlineInputBorder,
  focusedBorder: outlineInputBorder,
  border: outlineInputBorder,
);

TextTheme textTheme = const TextTheme(
  bodyLarge: TextStyle(color: Color(0xFF8B8B8B)),
  bodyMedium: TextStyle(color: Color(0xFF8B8B8B)),
);

AppBarTheme appBarTheme = const AppBarTheme(
  color: Colors.white,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.black),
  systemOverlayStyle: SystemUiOverlayStyle.light,
  titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  toolbarTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  centerTitle: true,
);
