import 'package:calendar_scheduler/practice%20calendar/database/table/category_colors.dart';
import 'package:drift/drift.dart';

class ScheduleItems extends Table {
  late final id = integer().autoIncrement()();
  late final startTime = integer()();
  late final endTime = integer()();
  late final content = text()();
  late final date = dateTime()();
  late final categoryColorId = integer().references(CategoryColors, #id)();
  late final createdAt = dateTime().clientDefault(() => DateTime.now())();
}
