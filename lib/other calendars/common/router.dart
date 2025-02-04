import 'package:calendar_scheduler/calendar_type/s_basic_calendar.dart';
import 'package:calendar_scheduler/calendar_type/s_events_calendar.dart';
import 'package:calendar_scheduler/calendar_type/s_range_calendar.dart';
import 'package:calendar_scheduler/practice%20calendar/calendar/screen/s_practice_calendar.dart';
import 'package:calendar_scheduler/s_home.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SHome(),
    ),
    GoRoute(
      path: '/s_practice_calendar',
      builder: (context, state) => SPracticeCalendar(),
    ),
    GoRoute(
      path: '/s_basic_calendar',
      builder: (context, state) => SBasicCalendar(),
    ),
    GoRoute(
      path: '/s_range_calendar',
      builder: (context, state) => SRangeCalendar(),
    ),
    GoRoute(
      path: '/s_events_calendar',
      builder: (context, state) => SEventsCalendar(),
    ),
  ],
);
