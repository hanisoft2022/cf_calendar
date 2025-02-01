import 'package:drift/drift.dart';

class CategoryColors extends Table {
  late final id = integer().autoIncrement()();

  late final color = text()();

  // DateTimeColumn get createdAt =>
  //     dateTime().clientDefault(() => DateTime.now())();
}
