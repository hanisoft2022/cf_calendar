import 'package:calendar_scheduler/practice%20calendar/0_common/constant/color.dart';

import 'package:calendar_scheduler/practice%20calendar/0_common/provider/provider.dart';

import 'package:calendar_scheduler/practice%20calendar/calendar/fragment/f_table_calendar.dart';
import 'package:calendar_scheduler/practice%20calendar/calendar/fragment/f_today_banner.dart';

import 'package:calendar_scheduler/practice%20calendar/calendar/fragment/today_schedule_list/f_today_schedule_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SPracticeCalendar extends ConsumerWidget {
  static const String routeName = 's_practice_calendar';

  const SPracticeCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarStateNotifier = ref.read(calendarProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('연습')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          calendarStateNotifier.onFloatingActionButtonPressed(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          FTableCalendar(),
          FTodayBanner(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: FTodayScheduleList(),
            ),
          ),
        ],
      ),
    );
  }
}
