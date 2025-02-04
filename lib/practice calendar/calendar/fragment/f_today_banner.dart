import 'package:calendar_scheduler/practice%20calendar/0_common/constant/color.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FTodayBanner extends ConsumerWidget {
  const FTodayBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProvider);
    final selectedDay = calendarState.selectedDay;
    final taskCount = ref.watch(scheduleItemCountProvider).value ?? 0;

    return Container(
      color: primaryColor.withAlpha(50),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('${selectedDay.year}. ${selectedDay.month}. ${selectedDay.day}'), Text('일정 $taskCount 개')],
      ),
    );
  }
}
