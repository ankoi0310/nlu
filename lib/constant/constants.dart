import 'package:flutter/material.dart';

import '../config/size_config.dart';

const Color primaryColor = Color(0xF335BB48);
// secondary color is lighter than primary color
const Color secondaryColor = Color(0x7B35BB48);
const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF0A0E21);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;

const courseColors = [
  // 4 green colors from dark to light
  Color(0xFF1B5E20),
  Color(0xFF388E3C),
  Color(0xFF4CAF50),
  Color(0xFF81C784),
];

// Calendar text style
TextStyle defaultTextStyle({required BuildContext context}) {
  return TextStyle(
    fontSize: getProportionateScreenWidth(16),
    fontWeight: FontWeight.bold,
    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
    height: 1.5,
  );
}

final todayTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(16),
  fontWeight: FontWeight.bold,
  color: Colors.white,
  height: 1.5,
);

TextStyle selectedTextStyle({required BuildContext context}) {
  return TextStyle(
    fontSize: getProportionateScreenWidth(16),
    fontWeight: FontWeight.bold,
    color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
    height: 1.5,
  );
}

final weekendTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(16),
  fontWeight: FontWeight.bold,
  color: Colors.red,
);

final holidayTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(16),
  fontWeight: FontWeight.bold,
  color: Colors.red,
  height: 1.5,
);

// Form Error
const String kUsernameNullError = "Vui lòng nhập tài khoản";
const String kPasswordNullError = "Vui lòng nhập mật khẩu";
const String kInvalidLogin = "Sai tài khoản hoặc mật khẩu";
