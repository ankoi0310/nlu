import 'package:flutter/cupertino.dart';
import 'package:nlu/screen/contact/contact_screen.dart';
import 'package:nlu/screen/home/home_screen.dart';
import 'package:nlu/screen/login/login_screen.dart';
import 'package:nlu/screen/notification/notification_screen.dart';
import 'package:nlu/screen/profile/profile_screen.dart';
import 'package:nlu/screen/setting/setting_screen.dart';

final Map<String, Widget> routes = {
  HomeScreen.routeName: const HomeScreen(),
  ProfileScreen.routeName: const ProfileScreen(),
  LoginScreen.routeName: const LoginScreen(),
  SettingScreen.routeName: const SettingScreen(),
  NotificationScreen.routeName: const NotificationScreen(),
  ContactScreen.routeName: const ContactScreen(),
};
