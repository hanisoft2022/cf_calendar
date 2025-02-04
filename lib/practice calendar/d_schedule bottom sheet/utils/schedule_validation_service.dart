// validation_service.dart
class ScheduleValidationService {
  // 시작 시간 검증
  static String? validateStart(String? val) {
    if (val == null || val.isEmpty) return '시작 시각을 입력하세요';
    if (int.tryParse(val) == null) return '유효한 숫자를 입력하세요.';
    final time = int.parse(val);
    if (time < 1 || time > 24) return '1~24 사이의 숫자 입력하세요.';
    return null;
  }

  // 종료 시간 검증
  static String? validateEnd(String? val) {
    if (val == null || val.isEmpty) return '종료 시각을 입력하세요';
    if (int.tryParse(val) == null) return '유효한 숫자를 입력하세요.';
    final time = int.parse(val);
    if (time < 1 || time > 24) return '1~24 사이의 숫자 입력하세요.';
    return null;
  }

  // 내용 검증
  static String? validateContent(String? val) {
    if (val == null || val.isEmpty) return '내용을 입력하세요.';
    return null;
  }
}
