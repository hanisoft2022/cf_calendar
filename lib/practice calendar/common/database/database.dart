import 'dart:io';

import 'package:calendar_scheduler/practice%20calendar/common/database/table/category_colors.dart';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:calendar_scheduler/practice%20calendar/common/database/table/schedule_items.dart';

import '../../model/m_schedule_with_category.dart';

part 'database.g.dart';

@DriftDatabase(tables: [ScheduleItems, CategoryColors])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // #region ==================== CRUD: Create ====================

  // 새로운 카테고리 색상 생성 (main.dart 초기화용)
  Future<int> createCategoryColors(CategoryColorsCompanion entry) => into(categoryColors).insert(entry);

  /// 새 일정 추가
  Future<int> addSchedule(ScheduleItemsCompanion entry) => into(scheduleItems).insert(entry);
  // #endregion

  // #region ==================== CRUD: Read ====================

  // 모든 카테고리 색상 조회 (main.dart 초기화용)
  Future<List<CategoryColor>> get getCategoryColors => select(categoryColors).get();

  // ID로 스케쥴 가져오기
  Future<MScheduleWithCategory> getScheduleWithCategoryById(int id) async {
    final query = select(scheduleItems).join(
      [
        innerJoin(
          categoryColors,
          categoryColors.id.equalsExp(
            scheduleItems.categoryColorId,
          ),
        ),
      ],
    )..where(scheduleItems.id.equals(id));

    // 선택지 2.
    return query.map(
      (row) {
        return MScheduleWithCategory(
          scheduleItem: row.readTable(scheduleItems),
          categoryColor: row.readTable(categoryColors),
        );
      },
    ).getSingle();
  }

  // 특정 날짜 일정 실시간 모니터링 (스트림)
  Stream<List<MScheduleWithCategory>> watchScheduleItems(DateTime date) {
    final query = select(scheduleItems).join(
      [
        innerJoin(
          categoryColors,
          categoryColors.id.equalsExp(
            scheduleItems.categoryColorId,
          ),
        ),
      ],
    )
      ..where(scheduleItems.date.equals(date))
      ..orderBy(
        [OrderingTerm(expression: scheduleItems.startTime), OrderingTerm(expression: scheduleItems.endTime)],
      );

    // 선택지 1. 먼저 watch()를 호출하여 스트림을 생성한 후, 스트림 내의 각 이벤트를 map과 toList로 변환
    // return query.watch().map(
    //   (event) {
    //     return event.map(
    //       (row) {
    //         return MScheduleWithCategory(
    //           scheduleItem: row.readTable(scheduleItems),
    //           categoryColor: row.readTable(categoryColors),
    //         );
    //       },
    //     ).toList();
    //   },
    // );

    // 선택지 2.
    return query.map(
      (row) {
        return MScheduleWithCategory(
          scheduleItem: row.readTable(scheduleItems),
          categoryColor: row.readTable(categoryColors),
        );
      },
    ).watch();
/*
    return (select(scheduleItems)
          ..where(
            (tbl) => tbl.date.equals(date),
          )
          ..orderBy(
            [
              (tbl) => OrderingTerm(expression: tbl.startTime),
              (tbl) =>
                  OrderingTerm(expression: tbl.endTime, mode: OrderingMode.asc),
            ],
          ))
        .watch();
        */
  }

  // 스케쥴 수 watch
  // AppDatabase 클래스 내의 watchScheduleCount 함수 최적화
  Stream<int> watchScheduleCount(DateTime date) {
    return (select(scheduleItems)..where((tbl) => tbl.date.equals(date))).watch().map((event) => event.length);
  }

  // #endregion

  // #region ==================== CRUD: Update ====================
  /// ID로 일정 업데이트
  Future<int> updateScheduleById(int id, ScheduleItemsCompanion entry) {
    return (update(scheduleItems)
          ..where((tbl) {
            return tbl.id.equals(id);
          }))
        .write(entry);
  }
  // #endregion

  // #region ==================== CRUD: Delete ====================

  // ID로 일정 삭제
  Future<int> deleteScheduleById(int id) => (delete(scheduleItems)..where((t) => t.id.equals(id))).go();
  // #endregion

  // #region ==================== Database Configuration ====================
  @override
  int get schemaVersion => 1;
  // #endregion
}

// #region ==================== Database Connection ====================
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;

    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}
  // #endregion