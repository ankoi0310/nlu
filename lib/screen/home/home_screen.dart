import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nlu/components/custom_app_bar.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/constant/constants.dart';
import 'package:nlu/domain/subject.dart';
import 'package:nlu/provider/dkmh_provider.dart';
import 'package:nlu/screen/home/components/course_card.dart';
import 'package:nlu/utils/app_utils.dart';
import 'package:provider/provider.dart';

import 'components/calendar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DKMHProvider provider;
  DateTime current = DateTime.now();
  List<Subject> subjects = [];

  bool checkValidDate(DateTime currentDate, String timespan) {
    List<String> dates = timespan.split(" đến ");
    final start = DateFormat("dd/MM/yy").parse(dates[0], true);
    final end = DateFormat("dd/MM/yy").parse(dates[1], true);
    return (current.isAfter(start) && current.isBefore(end)) ||
        current.isAtSameMomentAs(start) ||
        current.isAtSameMomentAs(end);
  }

  List<Subject> filterSubjects(List<Subject> subjects) {
    subjects = subjects
        .where((subject) => subject.thu == current.weekday + 1 && checkValidDate(current, subject.tkb))
        .toList();
    subjects.sort((a, b) => a.tbd.compareTo(b.tbd));
    return subjects;
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Cho phép ứng dụng gửi thông báo"),
            content:
                const Text("Ứng dụng cần được cho phép gửi thông báo để có thể thông báo cho bạn khi sắp đến giờ học."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Đóng",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Navigator.pop(context));
                },
                child: const Text(
                  "Cho phép",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    provider = Provider.of<DKMHProvider>(context, listen: false);
    subjects = filterSubjects(provider.schedule!.ds_nhom_to);

    saveStringToPrefs("subjects", jsonEncode(provider.schedule!.ds_nhom_to.map((e) => e.toJson()).toList()));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: getProportionateScreenHeight(20),
              ),
              child: const CustomAppBar(title: "Thời khóa biểu"),
            ),
            Calendar(
              current: current,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  current = selectedDay;
                  subjects = filterSubjects(provider.schedule!.ds_nhom_to);
                });
              },
              subjects: provider.schedule!.ds_nhom_to,
            ),
            const Divider(
              thickness: 2,
              height: 2,
            ),
            Flexible(
              child: ListView(
                children: [
                  ...List.generate(
                    subjects.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: CourseCard(
                        subject: subjects[index],
                        color: courseColors[index],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
