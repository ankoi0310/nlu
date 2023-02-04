import 'package:flutter/material.dart';

const Map<int, TimeOfDay> timeline = {
  1: TimeOfDay(hour: 7, minute: 0), // ca 1
  4: TimeOfDay(hour: 9, minute: 30), // ca 2
  7: TimeOfDay(hour: 12, minute: 15), // ca 3
  10: TimeOfDay(hour: 14, minute: 45), // ca 4
  13: TimeOfDay(hour: 17, minute: 30), // ca 5
};

const Map<int, String> timeBefore = {
  15: "Trước 15 phút",
  30: "Trước 30 phút",
  45: "Trước 45 phút",
  60: "Trước 1 giờ",
  0: "Không thông báo",
};

TimeOfDay createNotificationTime(int timeBefore, TimeOfDay timeOfDay) {
  int hour = timeOfDay.hour;
  int minute = timeOfDay.minute;

  if (minute - timeBefore < 0) {
    hour -= 1;
    minute = 60 - (timeBefore - minute);
  } else {
    minute -= timeBefore;
  }

  return TimeOfDay(hour: hour, minute: minute);
}
