import 'package:nlu/screen/contact/contact_screen.dart';
import 'package:nlu/screen/home/home_screen.dart';
import 'package:nlu/screen/notification/notification_screen.dart';
import 'package:nlu/screen/profile/profile_screen.dart';
import 'package:nlu/screen/setting/setting_screen.dart';
import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src, route;
  late SMIBool? input;

  RiveAsset(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    required this.route,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Contact Us",
    route: ContactScreen.routeName,
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notification",
    route: NotificationScreen.routeName,
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
    route: HomeScreen.routeName,
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "SETTINGS",
    stateMachineName: "SETTINGS_Interactivity",
    title: "Settings",
    route: SettingScreen.routeName,
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Profile",
    route: ProfileScreen.routeName,
  ),
];

List<RiveAsset> sideMenus = [
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
    route: HomeScreen.routeName,
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Profile",
    route: ProfileScreen.routeName,
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notification",
    route: NotificationScreen.routeName,
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Contact Us",
    route: ContactScreen.routeName,
  ),
];

List<RiveAsset> sideMenu2 = [
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "SETTINGS",
    stateMachineName: "SETTINGS_Interactivity",
    title: "Settings",
    route: SettingScreen.routeName,
  ),
];
