import 'package:calendar_scheduler/common/constant/calendar_constant.dart';

import 'package:calendar_scheduler/practice%20calendar/0_common/constant/style.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:table_calendar/table_calendar.dart';

class FTableCalendar extends ConsumerWidget {
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  const FTableCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProvider);
    final calendarStateNotifier = ref.read(calendarProvider.notifier);

    return TableCalendar(
      locale: 'ko_KR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: calendarState.focusedDay,
      availableCalendarFormats: availableCalendarFormats,
      onDaySelected: (selectedDay, focusedDay) => calendarStateNotifier.onDaySelected(selectedDay, focusedDay),
      selectedDayPredicate: (day) => isSameDay(calendarState.selectedDay, day),
      calendarFormat: _calendarFormat,
      onPageChanged: (focusedDay) => {calendarStateNotifier.onPageChanged(focusedDay)},
      headerStyle: headerStyle,
      calendarStyle: calendarStyle,
    );
  }
}
