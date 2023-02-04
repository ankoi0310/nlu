import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nlu/components/custom_child_app_bar.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/constant/timeline.dart';
import 'package:nlu/domain/subject.dart';
import 'package:nlu/utils/app_utils.dart';
import 'package:nlu/utils/notifications.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({
    Key? key,
    required this.selectedTime,
  }) : super(key: key);

  final int selectedTime;

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late int selectedTime = widget.selectedTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
          title: "Thời gian thông báo",
        ),
        body: Container(
          margin: EdgeInsets.only(top: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              ...timeBefore.keys.map((key) {
                return RadioListTile(
                  title: Text(
                    timeBefore[key]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: key,
                  controlAffinity: ListTileControlAffinity.trailing,
                  groupValue: selectedTime,
                  selected: selectedTime == key,
                  onChanged: (value) {
                    saveIntToPrefs("time_before", value as int);
                    setState(() {
                      selectedTime = value;
                    });

                    if (selectedTime == 0) {
                      cancelAllScheduledNotifications();
                      if (kDebugMode) {
                        print("Cancel all notifications");
                      }
                    } else {
                      getStringFromPrefs("subjects").then((value) async {
                        cancelAllScheduledNotifications();
                        List<Subject> subjects = jsonDecode(value!).map<Subject>((e) => Subject.fromJson(e)).toList();
                        for (var subject in subjects) {
                          int thu = subject.thu; // Thứ
                          TimeOfDay studyTime = timeline[subject.tbd]!; // Thời gian bắt đầu
                          TimeOfDay notiTime = createNotificationTime(selectedTime, studyTime); // Thời gian thông báo

                          await createNotification(
                            title: "Thông báo",
                            body: "Còn ${timeBefore[selectedTime]} nữa sẽ bắt đầu ${subject.ten_mon}",
                            schedule: NotificationCalendar(
                              allowWhileIdle: true,
                              weekday: thu - 1,
                              hour: notiTime.hour,
                              minute: notiTime.minute,
                            ),
                          );

                          if (kDebugMode) {
                            print(
                                "Create notification for ${subject.ten_mon} at ${notiTime.hour}:${notiTime.minute} on $thu");
                          }
                        }

                        // Test
                        // subjects.add(subjects[0]);
                        // Subject subject = subjects.last;
                        // await createNotification(
                        //   title: "Thông báo",
                        //   body: "Còn ${timeBefore[selectedTime]} nữa sẽ bắt đầu ${subject.ten_mon}",
                        //   schedule: NotificationCalendar(
                        //     allowWhileIdle: true,
                        //     weekday: 6,
                        //     hour: DateTime.now().hour,
                        //     minute: DateTime.now().minute + 1,
                        //   ),
                        // );

                        if (kDebugMode) {
                          List<NotificationModel> list = await getAllScheduleNotifications();
                          print("All notifications: ${list.length}");
                        }
                      });
                    }
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
