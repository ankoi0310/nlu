import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/constant/constants.dart';
import 'package:nlu/domain/subject.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    required this.current,
    required this.onDaySelected,
    required this.subjects,
  }) : super(key: key);

  final DateTime current;
  final Function onDaySelected;
  final List<Subject> subjects;

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
        markersAlignment: Alignment.bottomRight,
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          int amount = widget.subjects.where((subject) {
            List<String> dates = subject.tkb.split(" đến ");
            final start = DateFormat("dd/MM/yy").parse(dates[0], true);
            final end = DateFormat("dd/MM/yy").parse(dates[1], true);
            bool isValid = (date.isAfter(start) && date.isBefore(end)) ||
                date.isAtSameMomentAs(start) ||
                date.isAtSameMomentAs(end);
            return subject.thu == date.weekday + 1 && isValid;
          }).length;
          return amount > 0
              ? Container(
                  margin: EdgeInsets.only(
                    right: getProportionateScreenWidth(5),
                    bottom: getProportionateScreenWidth(5),
                  ),
                  width: getProportionateScreenWidth(14),
                  height: getProportionateScreenWidth(14),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        amount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox();
        },
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
