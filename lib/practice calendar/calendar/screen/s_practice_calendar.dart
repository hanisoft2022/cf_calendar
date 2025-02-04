import 'package:calendar_scheduler/practice%20calendar/0_common/constant/color.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/provider/provider.dart';

import 'package:calendar_scheduler/practice%20calendar/calendar/fragment/f_table_calendar.dart';
import 'package:calendar_scheduler/practice%20calendar/calendar/fragment/f_today_banner.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/model/m_schedule_with_category.dart';

import 'package:calendar_scheduler/practice%20calendar/calendar/widget/w_schedule_card.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import 'package:table_calendar/table_calendar.dart';

class SPracticeCalendar extends ConsumerWidget {
  const SPracticeCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProvider);
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
          FTableCalendar(
            focusedDay: calendarState.focusedDay,
            onDaySelected: (selectedDay, focusedDay) => calendarStateNotifier.onDaySelected(selectedDay, focusedDay),
            selectedDayPredicate: (day) => isSameDay(calendarState.selectedDay, day),
            onPageChanged: (focusedDay) => {calendarStateNotifier.onPageChanged(focusedDay)},
          ),
          StreamBuilder<int>(
              stream: GetIt.I<AppDatabase>().watchScheduleCount(calendarState.selectedDay),
              builder: (context, snapshot) {
                return FTodayBanner(selectedDay: calendarState.selectedDay, taskCount: snapshot.data ?? 0);
              }),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: StreamBuilder<List<MScheduleWithCategory>>(
                  stream: GetIt.I<AppDatabase>().watchScheduleItems(normalizeDate(calendarState.selectedDay)),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Center(child: Text('스트림이 연결되지 않았습니다.'));
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('일정이 없습니다.'));
                        }
                        final selectedSchedules = snapshot.data!;
                        return ListView.separated(
                          itemCount: selectedSchedules.length,
                          itemBuilder: (_, index) {
                            final scheduleWithCategory = selectedSchedules[index];
                            final schedule = scheduleWithCategory.scheduleItem;
                            final categoryColor = scheduleWithCategory.categoryColor;

                            return Dismissible(
                              key: ValueKey<int>(schedule.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                decoration:
                                    BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20), color: Colors.blue[100]),
                              ),
                              onDismissed: (DismissDirection direction) {
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
                                        duration: const Duration(seconds: 3)),
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
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
