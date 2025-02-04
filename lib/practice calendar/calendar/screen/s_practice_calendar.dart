import 'package:calendar_scheduler/practice%20calendar/common/constant/color.dart';
import 'package:calendar_scheduler/practice%20calendar/common/database/database.dart';

import 'package:calendar_scheduler/practice%20calendar/calendar/fragment/f_table_calendar.dart';
import 'package:calendar_scheduler/practice%20calendar/calendar/fragment/f_today_banner.dart';
import 'package:calendar_scheduler/practice%20calendar/common/model/m_schedule_with_category.dart';
import 'package:calendar_scheduler/practice%20calendar/common/database/table/schedule_items.dart';

import 'package:calendar_scheduler/practice%20calendar/dialog_schedule_bottom_sheet/dialog/d_schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/practice%20calendar/calendar/widget/w_schedule_card.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import 'package:table_calendar/table_calendar.dart';

class SPracticeCalendar extends StatefulWidget {
  const SPracticeCalendar({super.key});

  @override
  State<SPracticeCalendar> createState() => _SPracticeCalendarState();
}

class _SPracticeCalendarState extends State<SPracticeCalendar> {
  DateTime _focusedDay = DateTime.now();

  DateTime _selectedDay = DateTime.now();

  void _onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        // _selectedDay = normalizeDate(selectedDay);
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  bool _selectedDayPredicate(day) {
    return isSameDay(_selectedDay, day);
  }

  final _textEditingControllerForStartTime = TextEditingController();
  final _textEditingControllerForEndTime = TextEditingController();
  final _textEditingControllerForContent = TextEditingController();

  void onFloatingActionButtonPressed() {
    showModalBottomSheet<ScheduleItems?>(
      context: context,
      builder: (context) => SafeArea(
        child: DScheduleBottomSheet(
          selectedDay: normalizeDate(
            _selectedDay,
          ),
        ),
      ),
    );
  }

  void _onWScheduleCardTap(ScheduleItem individualSchedule) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: DScheduleBottomSheet(
          selectedDay: normalizeDate(
            _selectedDay,
          ),
          id: individualSchedule.id,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerForStartTime.dispose();
    _textEditingControllerForEndTime.dispose();
    _textEditingControllerForContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('연습')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: onFloatingActionButtonPressed,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          FTableCalendar(
            focusedDay: _focusedDay,
            onDaySelected: _onDaySelected,
            selectedDayPredicate: _selectedDayPredicate,
            onPageChanged: (focusedDay) => _focusedDay = focusedDay,
          ),
          StreamBuilder<int>(
              stream: GetIt.I<AppDatabase>().watchScheduleCount(_selectedDay),
              builder: (context, snapshot) {
                return FTodayBanner(selectedDay: _selectedDay, taskCount: snapshot.data ?? 0);
              }),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: StreamBuilder<List<MScheduleWithCategory>>(
                  stream: GetIt.I<AppDatabase>().watchScheduleItems(normalizeDate(_selectedDay)),
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
                                onWScheduleCardTap: () => _onWScheduleCardTap(schedule),
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
