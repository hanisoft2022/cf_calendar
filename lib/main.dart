import 'package:calendar_scheduler/common/router/router.dart';
import 'package:calendar_scheduler/practice%20calendar/0_common/database/database.dart';

import 'package:drift/drift.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'practice calendar/d_schedule bottom sheet/constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = AppDatabase();

  GetIt.I.registerSingleton<AppDatabase>(database);

  final colors = await database.getCategoryColors;

  if (colors.isEmpty) {
    for (final categoryColor in categoryColors) {
      await database.createCategoryColors(CategoryColorsCompanion(color: Value(categoryColor)));
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
