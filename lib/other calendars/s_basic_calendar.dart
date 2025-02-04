import 'package:calendar_scheduler/other%20calendars/common/constant/calendar_constant.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SBasicCalendar extends StatefulWidget {
  const SBasicCalendar({super.key});

  @override
  SBasicCalendarState createState() => SBasicCalendarState();
}

class SBasicCalendarState extends State<SBasicCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기본'),
      ),
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        availableCalendarFormats: availableCalendarFormats,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
