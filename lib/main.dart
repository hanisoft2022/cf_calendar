import 'package:calendar_scheduler/other%20calendars/common/router.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';

import 'package:drift/drift.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'practice calendar/dialog_schedule_bottom_sheet/constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = AppDatabase();

  GetIt.I.registerSingleton<AppDatabase>(database);

  final colors = await database.getCategoryColors;

  if (colors.isEmpty) {
    for (final color in categoryColors) {
      await database.createCategoryColors(CategoryColorsCompanion(color: Value(color)));
    }
  }

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
