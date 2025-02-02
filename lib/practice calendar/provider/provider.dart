import 'package:calendar_scheduler/practice%20calendar/database/drift.dart';
import 'package:calendar_scheduler/practice%20calendar/model/m_schedule_with_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarState {
  final DateTime focusedDay;
  final DateTime selectedDay;

  CalendarState({
    required this.focusedDay,
    required this.selectedDay,
  });

  CalendarState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
  }) {
    return CalendarState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}

// ---------------------------- //
final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>((ref) {
  return CalendarNotifier();
});

class CalendarNotifier extends StateNotifier<CalendarState> {
  CalendarNotifier()
      : super(CalendarState(
          focusedDay: DateTime.now(),
          selectedDay: DateTime.now(),
        ));

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(state.selectedDay, selectedDay)) {
      state = state.copyWith(
        selectedDay: selectedDay,
        focusedDay: focusedDay,
      );
    }
  }

  void onPageChanged(DateTime focusedDay) {
    state = state.copyWith(focusedDay: focusedDay);
  }
}

// ---------------------------- //
final scheduleCountProvider = StreamProvider.family<int, DateTime>((ref, selectedDay) {
  return GetIt.I<AppDatabase>().watchScheduleCount(selectedDay);
});
// ---------------------------- //
final scheduleItemsProvider = StreamProvider.family<List<MScheduleWithCategory>, DateTime>((ref, selectedDay) {
  return GetIt.I<AppDatabase>().watchScheduleItems(normalizeDate(selectedDay));
});
