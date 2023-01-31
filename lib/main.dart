import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nlu/config/theme.dart';
import 'package:nlu/constant/constants.dart';
import 'package:nlu/provider/change_widget_notifier.dart';
import 'package:nlu/provider/dkmh_provider.dart';
import 'package:nlu/screen/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher_foreground',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: primaryColor,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled notifications',
        channelDescription: 'Scheduled notifications',
        defaultColor: primaryColor,
        locked: true,
        importance: NotificationImportance.High,
      ),
    ],
  );
  initializeDateFormatting().then(
    (_) => runApp(ChangeNotifierProvider(
      create: (_) => ChangeWidgetNotifier(),
      child: const MyApp(),
    )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => DKMHProvider()),
      ],
      child: MaterialApp(
        title: 'NLU',
        theme: theme,
        home: const OnboardingScreen(),
      ),
    );
  }
}
