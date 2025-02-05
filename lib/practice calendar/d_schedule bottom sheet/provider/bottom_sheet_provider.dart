import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/provider/app_database_provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// #region ScheduleFormState
/// 폼에 필요한 상태를 관리하는 모델 클래스
class ScheduleFormState {
  final int? startTime; // 시작 시각 (1~24 값)
  final int? endTime; // 종료 시각 (1~24 값)
  final String? content; // 일정 내용
  final int selectedColorId; // 선택된 카테고리 색상 id
  final bool isLoading; // 초기 데이터 로딩 여부

  ScheduleFormState({
    this.startTime,
    this.endTime,
    this.content,
    required this.selectedColorId,
    this.isLoading = true,
  });

  /// 현재 상태를 복사하면서 일부 값만 변경할 때 사용하는 메서드
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
// #endregion

// #region ScheduleFormNotifier
/// 폼의 입력값 업데이트 및 데이터베이스 저장 로직 등을 처리하는 StateNotifier
class ScheduleFormNotifier extends StateNotifier<ScheduleFormState> {
  // 일정 수정 시 scheduleId가 null이 아니고, 신규 추가면 null
  final int? scheduleId;
  // AppDatabase 인스턴스를 DI를 통해 주입받음 (appDatabaseProvider 사용)
  final AppDatabase _database;

  // 폼 위젯의 GlobalKey로 폼의 상태(검증, 저장 등)를 관리
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// 생성자: 데이터베이스 인스턴스와 scheduleId를 주입받아 상태를 초기화하고, _initCategory() 호출
  ScheduleFormNotifier({required AppDatabase database, this.scheduleId})
      : _database = database,
        super(ScheduleFormState(selectedColorId: 0, isLoading: true)) {
    _initCategory();
  }

  /// 데이터베이스에서 기존 일정 정보(수정 시) 또는 신규 일정을 위한 기본 카테고리 정보를 불러와 상태를 초기화
  Future<void> _initCategory() async {
    if (scheduleId != null) {
      // 기존 일정이면 DB에서 일정 및 카테고리 정보를 가져옴
      final resp = await _database.getScheduleWithCategoryById(scheduleId!);
      state = state.copyWith(
        selectedColorId: resp.categoryColor.id,
        startTime: resp.scheduleItem.startTime,
        endTime: resp.scheduleItem.endTime,
        content: resp.scheduleItem.content,
        isLoading: false,
      );
    } else {
      // 신규 일정이면 DB에서 카테고리 색상 목록을 불러와 기본 색상을 설정
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

  // #region Update Methods
  /// 시작 시각을 업데이트 (문자열을 정수로 파싱 후 1~24 값인지 확인)
  void updateStartTime(String value) {
    final parsed = int.tryParse(value);
    if (parsed != null && parsed >= 1 && parsed <= 24) {
      state = state.copyWith(startTime: parsed);
    }
  }

  /// 종료 시각을 업데이트 (문자열을 정수로 파싱 후 1~24 값인지 확인)
  void updateEndTime(String value) {
    final parsed = int.tryParse(value);
    if (parsed != null && parsed >= 1 && parsed <= 24) {
      state = state.copyWith(endTime: parsed);
    }
  }

  /// 일정 내용을 업데이트
  void updateContent(String value) {
    state = state.copyWith(content: value);
  }

  /// 선택한 카테고리 색상을 업데이트
  void updateSelectedColor(int colorHex) {
    state = state.copyWith(selectedColorId: colorHex);
  }
  // #endregion

  // #region Validator & onSaved Methods
  /// 시작 시각 입력값의 유효성을 검증하는 메서드
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

  /// 종료 시각 입력값의 유효성을 검증하는 메서드
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

  /// 시작 시각 입력값이 저장될 때 호출, updateStartTime()을 통해 상태 업데이트
  void onStartSaved(String? val) {
    if (val != null) {
      updateStartTime(val);
    }
  }

  /// 종료 시각 입력값이 저장될 때 호출, updateEndTime()을 통해 상태 업데이트
  void onEndSaved(String? val) {
    if (val != null) {
      updateEndTime(val);
    }
  }

  /// 일정 내용 입력값의 유효성을 검증하는 메서드
  String? validateContent(String? val) {
    if (val == null || val.isEmpty) {
      return '내용을 입력하세요.';
    }
    return null;
  }

  /// 일정 내용 입력값이 저장될 때 호출, updateContent()를 통해 상태 업데이트
  void onContentSaved(String? val) {
    if (val != null) {
      updateContent(val);
    }
  }
  // #endregion

  // #region Save Logic
  /// 폼 필드의 유효성 검증 후, 데이터베이스에 일정을 추가하거나 업데이트하는 메서드
  Future<void> saveSchedule(DateTime selectedDay) async {
    // 모든 필드가 입력되었는지 확인 (폼 검증은 Form 위젯의 validate() 호출에서 수행됨)
    if (state.startTime == null || state.endTime == null || state.content == null || state.content!.isEmpty) {
      return; // 필요에 따라 에러처리 추가 가능
    }

    final item = ScheduleItemsCompanion(
      startTime: Value(state.startTime!),
      endTime: Value(state.endTime!),
      categoryColorId: Value(state.selectedColorId),
      content: Value(state.content!),
      date: Value(selectedDay),
    );

    if (scheduleId == null) {
      // 신규 일정 추가
      await _database.addSchedule(item);
    } else {
      // 기존 일정 업데이트
      await _database.updateScheduleById(scheduleId!, item);
    }
  }
  // #endregion
}
// #endregion

// #region Providers
/// ScheduleFormNotifier를 생성하고, 그 결과 상태를 제공하는 Riverpod provider
final scheduleFormProvider = StateNotifierProvider.family<ScheduleFormNotifier, ScheduleFormState, int?>(
  (ref, scheduleId) => ScheduleFormNotifier(
    database: ref.read(appDatabaseProvider), // appDatabaseProvider로부터 AppDatabase 인스턴스 주입
    scheduleId: scheduleId,
  ),
);

/// 카테고리 색상 목록을 비동기로 제공하는 FutureProvider
final categoryColorsProvider = FutureProvider<List<CategoryColor>>((ref) async {
  final database = ref.watch(appDatabaseProvider);
  return await database.getCategoryColors;
});
// #endregion
