import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/database/table/schedule_items.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/model/m_schedule_with_category.dart';
import 'package:calendar_scheduler/practice%20calendar/d_schedule%20bottom%20sheet/dialog/d_schedule_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';

/// 캘린더 상태 모델 (선택된 날짜와 집중 날짜)
class CalendarState {
  final DateTime selectedDay;
  final DateTime focusedDay;

  CalendarState({
    required this.selectedDay,
    required this.focusedDay,
  });

  CalendarState copyWith({
    DateTime? selectedDay,
    DateTime? focusedDay,
  }) {
    return CalendarState(
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
    );
  }
}

// 캘린더 상태 관리 Notifier
class CalendarNotifier extends StateNotifier<CalendarState> {
  CalendarNotifier()
      : super(CalendarState(
          selectedDay: DateTime.now(),
          focusedDay: DateTime.now(),
        ));

  // 날짜 선택 시 호출되는 함수
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(state.selectedDay, selectedDay)) {
      state = state.copyWith(
        selectedDay: selectedDay,
        focusedDay: focusedDay,
      );
    }
  }

  // 페이지 변경 시 호출되는 함수
  void onPageChanged(DateTime focusedDay) {
    state = state.copyWith(focusedDay: focusedDay);
  }

  void onFloatingActionButtonPressed(BuildContext context) {
    showModalBottomSheet<ScheduleItems?>(
      context: context,
      builder: (context) => SafeArea(
        child: DScheduleBottomSheet(selectedDay: normalizeDate(state.selectedDay)),
      ),
    );
  }

  void onWScheduleCardTap(ScheduleItem individualSchedule, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: DScheduleBottomSheet(
          selectedDay: normalizeDate(
            state.selectedDay,
          ),
          id: individualSchedule.id,
        ),
      ),
    );
  }
}

// Provider 정의
final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>((ref) => CalendarNotifier());

// 선택된 날짜에 따른 일정 목록 스트림 제공자 : DB에서 일정 데이터를 읽어오도록 래핑
final selectedDateSchedulesProvider = StreamProvider.autoDispose<List<MScheduleWithCategory>>((ref) {
  // calendarProvider의 선택된 날짜를 구독
  final calendarState = ref.watch(calendarProvider);
  // 이 함수 normalizeDate는 기존에 쓰던 날짜 정규화 함수라고 가정
  final normalizedDate = normalizeDate(calendarState.selectedDay);
  // GetIt을 통해 AppDatabase 인스턴스에 접근하여 스트림 반환 (MScheduleWithCategory 목록)
  return ref.watch(appDatabaseProvider).watchScheduleItems(normalizedDate);
});

// 선택된 날짜의 일정 목록을 스트림으로 제공하는 Provider
final scheduleItemCountProvider = StreamProvider.autoDispose<int>((ref) {
  final calendarState = ref.watch(calendarProvider);
  return ref.watch(appDatabaseProvider).watchScheduleCount(calendarState.selectedDay);
});

// 기존에 GetIt 등록된 AppDatabase 인스턴스를 제공하는 provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  // 여기서 GetIt을 내부적으로 사용하지만, UI 및 다른 로직에서는 provider를 사용하게 됩니다.
  return GetIt.I<AppDatabase>();
});
