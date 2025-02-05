// 기존에 GetIt 등록된 AppDatabase 인스턴스를 제공하는 provider
import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  // 여기서 GetIt을 내부적으로 사용하지만, UI 및 다른 로직에서는 provider를 사용하게 됩니다.
  return GetIt.I<AppDatabase>();
});
