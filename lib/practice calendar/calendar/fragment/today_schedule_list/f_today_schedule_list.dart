import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/provider/provider.dart';
import 'package:calendar_scheduler/practice%20calendar/calendar/widget/w_schedule_card.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

class FTodayScheduleList extends ConsumerWidget {
  const FTodayScheduleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarStateNotifier = ref.read(calendarProvider.notifier);
    final selectedSchedules = ref.watch(scheduleStreamProvider);

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
            final schedule = scheduleWithCategory.scheduleItem;
            final categoryColor = scheduleWithCategory.categoryColor;
            return Dismissible(
              key: ValueKey<int>(schedule.id),
              direction: DismissDirection.endToStart,
              background: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[100],
                ),
              ),
              onDismissed: (direction) {
                final removedSchedule = scheduleWithCategory.scheduleItem;
                GetIt.I<AppDatabase>().deleteScheduleById(removedSchedule.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('일정이 삭제되었습니다.'),
                      action: SnackBarAction(
                        textColor: Colors.blue[100],
                        label: '실행취소',
                        onPressed: () {
                          GetIt.I<AppDatabase>().addSchedule(
                            ScheduleItemsCompanion(
                              id: Value(removedSchedule.id),
                              startTime: Value(removedSchedule.startTime),
                              endTime: Value(removedSchedule.endTime),
                              content: Value(removedSchedule.content),
                              categoryColorId: Value(categoryColor.id),
                              date: Value(removedSchedule.date),
                            ),
                          );
                        },
                      ),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: WScheduleCard(
                startTime: schedule.startTime,
                endTime: schedule.endTime,
                content: schedule.content,
                color: Color(int.parse('ff${categoryColor.color}', radix: 16)),
                onWScheduleCardTap: () {
                  calendarStateNotifier.onWScheduleCardTap(schedule, context);
                },
              ),
            );
          },
          separatorBuilder: (_, __) => const Gap(10),
        );
      },
    );
  }
}
