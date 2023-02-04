import 'package:flutter/material.dart';
import 'package:nlu/constant/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key, required this.current, required this.onDaySelected}) : super(key: key);

  final DateTime current;
  final Function onDaySelected;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: widget.current,
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      calendarStyle: CalendarStyle(
        todayDecoration: const BoxDecoration(
          color: secondaryColor,
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: defaultTextStyle(context: context),
        todayTextStyle: todayTextStyle,
        selectedTextStyle: selectedTextStyle(context: context),
        weekendTextStyle: weekendTextStyle,
        // holidayTextStyle: holidayTextStyle,
        // todayTextStyle: selectedTextStyle,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDaySelected(selectedDay, focusedDay);
      },
      selectedDayPredicate: (day) {
        return isSameDay(widget.current, day);
      },
    );
  }
}
