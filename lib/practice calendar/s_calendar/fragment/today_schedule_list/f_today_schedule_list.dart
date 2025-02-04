import 'package:calendar_scheduler/practice%20calendar/s_calendar/provider/calendar_provider.dart';
import 'package:calendar_scheduler/practice%20calendar/s_calendar/fragment/today_schedule_list/widget/w_dismissible_schedule_item.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class FTodayScheduleList extends ConsumerWidget {
  const FTodayScheduleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSchedules = ref.watch(selectedDateSchedulesProvider);

    return selectedSchedules.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (schedules) {
        if (schedules.isEmpty) {
          return const Center(child: Text('일정이 없습니다.'));
        }
        return ListView.separated(
          itemCount: schedules.length,
          itemBuilder: (_, index) {
            final scheduleWithCategory = schedules[index];

            return WDismissibleScheduleItem(scheduleWithCategory: scheduleWithCategory);
          },
          separatorBuilder: (_, __) => const Gap(10),
        );
      },
    );
  }
}
