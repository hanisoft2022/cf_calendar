import 'package:calendar_scheduler/common/constant/calendar_constant.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SRangeCalendar extends StatefulWidget {
  const SRangeCalendar({super.key});

  @override
  SRangeCalendarState createState() => SRangeCalendarState();
}

class SRangeCalendarState extends State<SRangeCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn; // Can be toggled on/off by long pressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('범위 선택'),
      ),
      body: TableCalendar(
        locale: 'ko_KR',
        availableCalendarFormats: availableCalendarFormats,
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        rangeSelectionMode: _rangeSelectionMode,
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _rangeStart = null; // Important to clean those
              _rangeEnd = null;
              _rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
          }
        },
        onRangeSelected: (start, end, focusedDay) {
          setState(() {
            _selectedDay = null;
            _focusedDay = focusedDay;
            _rangeStart = start;
            _rangeEnd = end;
            _rangeSelectionMode = RangeSelectionMode.toggledOn;
          });
        },
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
