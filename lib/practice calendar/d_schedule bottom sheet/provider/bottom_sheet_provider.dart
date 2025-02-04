import 'package:calendar_scheduler/practice calendar/0_common/database/database.dart';

import 'package:calendar_scheduler/practice%20calendar/s_calendar/provider/calendar_provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleEditorState {
  final int? startTime;
  final int? endTime;
  final String? content;
  final int? selectedColorId;
  final bool isLoading;

  ScheduleEditorState({
    this.startTime,
    this.endTime,
    this.content,
    this.selectedColorId,
    this.isLoading = true,
  });

  ScheduleEditorState copyWith({
    int? startTime,
    int? endTime,
    String? content,
    int? selectedColorId,
    bool? isLoading,
  }) {
    return ScheduleEditorState(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      content: content ?? this.content,
      selectedColorId: selectedColorId ?? this.selectedColorId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ScheduleEditorNotifier extends StateNotifier<ScheduleEditorState> {
  final int? scheduleId;
  final DateTime selectedDay;
  final AppDatabase db;

  ScheduleEditorNotifier({
    required this.selectedDay,
    this.scheduleId,
    required this.db,
  }) : super(ScheduleEditorState()) {
    _init();
  }

  // 초기 State를 로드 (수정모드면 기존 데이터, 신규면 기본 CategoryColors)
  Future<void> _init() async {
    if (scheduleId != null) {
      // 수정 모드: 해당 스케줄의 데이터를 가져옴
      final response = await db.getScheduleWithCategoryById(scheduleId!);
      state = state.copyWith(
        startTime: response.scheduleItem.startTime,
        endTime: response.scheduleItem.endTime,
        content: response.scheduleItem.content,
        selectedColorId: response.categoryColor.id,
        isLoading: false,
      );
    } else {
      // 신규 생성: CategoryColors의 첫번째 값으로 초기화
      final colors = await db.getCategoryColors;
      state = state.copyWith(
        selectedColorId: colors.first.id,
        isLoading: false,
      );
    }
  }

  void setStartTime(String value) {
    final time = int.tryParse(value);
    if (time != null) {
      state = state.copyWith(startTime: time);
    }
  }

  void setEndTime(String value) {
    final time = int.tryParse(value);
    if (time != null) {
      state = state.copyWith(endTime: time);
    }
  }

  void setContent(String value) {
    state = state.copyWith(content: value);
  }

  void setSelectedColorId(int colorId) {
    state = state.copyWith(selectedColorId: colorId);
  }

  Future<void> saveSchedule(DateTime selectedDay) async {
    if (state.startTime == null || state.endTime == null || state.content == null || state.selectedColorId == null) {
      throw Exception('필수 값을 입력해주세요.');
    }

    if (scheduleId == null) {
      await db.addSchedule(
        ScheduleItemsCompanion(
          startTime: Value(state.startTime!),
          endTime: Value(state.endTime!),
          content: Value(state.content!),
          categoryColorId: Value(state.selectedColorId!),
          date: Value(selectedDay),
        ),
      );
    } else {
      await db.updateScheduleById(
        scheduleId!,
        ScheduleItemsCompanion(
          startTime: Value(state.startTime!),
          endTime: Value(state.endTime!),
          content: Value(state.content!),
          categoryColorId: Value(state.selectedColorId!),
          date: Value(selectedDay),
        ),
      );
    }
  }
}

/// family을 통해 scheduleId (수정모드) 혹은 null(신규모드)을 인자로 받고, selectedDay와 함께 Notifier를 생성합니다.
final scheduleEditorProvider = StateNotifierProvider.family<ScheduleEditorNotifier, ScheduleEditorState, Map<String, dynamic>>((ref, params) {
  final db = ref.watch(appDatabaseProvider);
  return ScheduleEditorNotifier(
    selectedDay: params['selectedDay'] as DateTime,
    scheduleId: params['scheduleId'] as int?,
    db: db,
  );
});
