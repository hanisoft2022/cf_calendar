import 'package:calendar_scheduler/common/constant/calendar_constant.dart';

import 'package:calendar_scheduler/practice%20calendar/const/style.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

class FTableCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;
  final bool Function(DateTime day) selectedDayPredicate;
  final void Function(DateTime day) onPageChanged;

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  const FTableCalendar({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
    required this.selectedDayPredicate,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: focusedDay,
      availableCalendarFormats: availableCalendarFormats,
      onDaySelected: onDaySelected,
      selectedDayPredicate: selectedDayPredicate,
      calendarFormat: _calendarFormat,
      onPageChanged: onPageChanged,
      headerStyle: headerStyle,
      calendarStyle: calendarStyle,
    );
  }
}
