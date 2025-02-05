import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/provider/app_database_provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class ScheduleFormState {
  final int? startTime;
  final int? endTime;
  final String? content;
  final int selectedColorId;
  final bool isLoading;

  ScheduleFormState({
    this.startTime,
    this.endTime,
    this.content,
    required this.selectedColorId,
    this.isLoading = true,
  });

  ScheduleFormState copyWith({
    int? startTime,
    int? endTime,
    String? content,
    int? selectedColorId,
    bool? isLoading,
  }) {
    return ScheduleFormState(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      content: content ?? this.content,
      selectedColorId: selectedColorId ?? this.selectedColorId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ScheduleFormNotifier extends StateNotifier<ScheduleFormState> {
  // 일정 수정이면 scheduleId가 값 있음, 신규 추가면 null
  final int? scheduleId;
  final AppDatabase _database = GetIt.I<AppDatabase>();

  // Form 키 (폼의 유효성 검증에 사용)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ScheduleFormNotifier({this.scheduleId}) : super(ScheduleFormState(selectedColorId: 0, isLoading: true)) {
    _initCategory();
  }

  Future<void> _initCategory() async {
    if (scheduleId != null) {
      final resp = await _database.getScheduleWithCategoryById(scheduleId!);
      state = state.copyWith(
        selectedColorId: resp.categoryColor.id,
        startTime: resp.scheduleItem.startTime,
        endTime: resp.scheduleItem.endTime,
        content: resp.scheduleItem.content,
        isLoading: false,
      );
    } else {
      final colors = await _database.getCategoryColors;
      state = state.copyWith(
        selectedColorId: colors.first.id,
        startTime: null,
        endTime: null,
        content: null,
        isLoading: false,
      );
    }
  }

  // 기존 업데이트 메서드 (텍스트 필드 입력값을 상태에 반영)
  void updateStartTime(String value) {
    final parsed = int.tryParse(value);
    if (parsed != null && parsed >= 1 && parsed <= 24) {
      state = state.copyWith(startTime: parsed);
    }
  }

  void updateEndTime(String value) {
    final parsed = int.tryParse(value);
    if (parsed != null && parsed >= 1 && parsed <= 24) {
      state = state.copyWith(endTime: parsed);
    }
  }

  void updateContent(String value) {
    state = state.copyWith(content: value);
  }

  void updateSelectedColor(int colorHex) {
    state = state.copyWith(selectedColorId: colorHex);
  }

  // ===== 폼 필드용 Validator 및 onSaved 콜백 메서드 =====

  String? validateStartTime(String? val) {
    if (val == null || val.isEmpty) {
      return '시작 시각을 입력하세요';
    }
    if (int.tryParse(val) == null) {
      return '유효한 숫자를 입력하세요.';
    }
    final time = int.parse(val);
    if (time < 1 || time > 24) {
      return '1~24 사이의 숫자를 입력하세요.';
    }
    return null;
  }

  String? validateEndTime(String? val) {
    if (val == null || val.isEmpty) {
      return '끝나는 시각을 입력하세요';
    }
    if (int.tryParse(val) == null) {
      return '유효한 숫자를 입력하세요.';
    }
    final time = int.parse(val);
    if (time < 1 || time > 24) {
      return '1~24 사이의 숫자를 입력하세요.';
    }
    return null;
  }

  void onStartSaved(String? val) {
    if (val != null) {
      updateStartTime(val);
    }
  }

  void onEndSaved(String? val) {
    if (val != null) {
      updateEndTime(val);
    }
  }

  String? validateContent(String? val) {
    if (val == null || val.isEmpty) {
      return '내용을 입력하세요.';
    }
    return null;
  }

  void onContentSaved(String? val) {
    if (val != null) {
      updateContent(val);
    }
  }

  // 저장 로직 실행 메서드
  Future<void> saveSchedule(DateTime selectedDay) async {
    // 각 필드의 값 검증은 Form 위젯의 validate()를 통해 이미 수행되었다고 가정
    if (state.startTime == null || state.endTime == null || state.content == null || state.content!.isEmpty) {
      return; // 필요에 따라 에러처리 가능
    }

    final item = ScheduleItemsCompanion(
      startTime: Value(state.startTime!),
      endTime: Value(state.endTime!),
      categoryColorId: Value(state.selectedColorId),
      content: Value(state.content!),
      date: Value(selectedDay),
    );

    if (scheduleId == null) {
      await _database.addSchedule(item);
    } else {
      await _database.updateScheduleById(scheduleId!, item);
    }
  }
}

final scheduleFormProvider = StateNotifierProvider.family<ScheduleFormNotifier, ScheduleFormState, int?>(
  (ref, scheduleId) => ScheduleFormNotifier(scheduleId: scheduleId),
);

final categoryColorsProvider = FutureProvider<List<CategoryColor>>((ref) async {
  final database = ref.watch(appDatabaseProvider);
  return await database.getCategoryColors;
});
