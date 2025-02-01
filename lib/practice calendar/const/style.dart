import 'package:calendar_scheduler/common/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final BoxDecoration defaultBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
);

final BoxDecoration selectedBoxDecoration =
    defaultBoxDecoration.copyWith(color: primaryColor);

const TextStyle defaultTextStyle = TextStyle(color: Colors.black);

const HeaderStyle headerStyle = HeaderStyle(
  titleCentered: true,
  formatButtonVisible: false,
  titleTextStyle: TextStyle(
    fontFamily: 'NatoSans',
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
);

CalendarStyle calendarStyle = CalendarStyle(
  isTodayHighlighted: true,
  selectedTextStyle: defaultTextStyle,
  todayTextStyle: defaultTextStyle,
  defaultDecoration: defaultBoxDecoration,
  outsideDecoration: defaultBoxDecoration,
  weekendDecoration: defaultBoxDecoration,
  selectedDecoration: selectedBoxDecoration,
  todayDecoration:
      selectedBoxDecoration.copyWith(color: primaryColor.withOpacity(0.3)),
);
