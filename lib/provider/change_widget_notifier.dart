import 'package:flutter/material.dart';
import 'package:nlu/screen/home/home_screen.dart';

class ChangeWidgetNotifier extends ChangeNotifier {
  Widget activeWidget = const HomeScreen();

  void changeActiveWidget(Widget newWidget) {
    if (activeWidget == newWidget) {
      return;
    }

    activeWidget = newWidget;
    notifyListeners();
  }
}
