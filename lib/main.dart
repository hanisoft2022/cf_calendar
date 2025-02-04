import 'package:calendar_scheduler/common/router/router.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'practice calendar/d_schedule bottom sheet/constant/constant.dart';

/// 애플리케이션의 진입점(Entry point)
void main() async {
  // Flutter 엔진 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 현재 로케일에 맞게 날짜 형식을 초기화 (예: 한글, 영어 등)
  await initializeDateFormatting();

  // 데이터베이스 인스턴스를 생성
  final database = AppDatabase();

  // GetIt을 사용해 AppDatabase 인스턴스를 전역에서 사용할 수 있도록 등록
  GetIt.I.registerSingleton<AppDatabase>(database);

  // 데이터베이스 내의 기존 카테고리 색상 데이터를 가져옴
  final colors = await database.getCategoryColors;

  // 만약 카테고리 색상 데이터가 없다면, 미리 정의된 기본 색상 목록을 데이터베이스에 삽입
  if (colors.isEmpty) {
    // categoryColors는 미리 정의된 기본 색상 코드 목록입니다.
    for (final categoryColor in categoryColors) {
      await database.createCategoryColors(CategoryColorsCompanion(color: Value(categoryColor)));
    }
  }

  // 앱 실행: ProviderScope를 통해 Riverpod 상태 관리 사용, routerConfig로 라우팅 설정
  runApp(
    ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TableCalendar Example',
        theme: ThemeData(fontFamily: 'NotoSans'),
        routerConfig: router,
      ),
    ),
  );
}
