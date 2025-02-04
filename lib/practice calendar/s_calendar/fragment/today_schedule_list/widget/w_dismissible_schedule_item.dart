// schedule_dismissible_item.dart
import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';

import 'package:calendar_scheduler/practice%20calendar/0_common/model/m_schedule_with_category.dart';
import 'package:calendar_scheduler/practice%20calendar/s_calendar/widget/w_schedule_card.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calendar_scheduler/practice%20calendar/s_calendar/provider/calendar_provider.dart';

class WDismissibleScheduleItem extends ConsumerWidget {
  final MScheduleWithCategory scheduleWithCategory;

  const WDismissibleScheduleItem({super.key, required this.scheduleWithCategory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = scheduleWithCategory.scheduleItem;
    final categoryColor = scheduleWithCategory.categoryColor;
    final calendarStateNotifier = ref.read(calendarProvider.notifier);

    final db = ref.read(appDatabaseProvider);
    return Dismissible(
      key: ValueKey<int>(schedule.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20), color: Colors.blue[100]),
      ),
      onDismissed: (direction) {
        final removedSchedule = scheduleWithCategory.scheduleItem;
        // 삭제 로직: GetIt을 활용하여 데이터베이스 작업 수행
        db.deleteScheduleById(removedSchedule.id);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('일정이 삭제되었습니다.'),
              action: SnackBarAction(
                textColor: Colors.blue[100],
                label: '실행취소',
                onPressed: () {
                  db.addSchedule(
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
  }
}
