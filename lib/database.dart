import 'package:drift/drift.dart';
// import 'package:drift_flutter/drift_flutter.dart';
// import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:drift/native.dart';

part 'database.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text().withLength(max: 99)();
  IntColumn get stok => integer()();
  IntColumn get harga => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

@DriftDatabase(tables: [Items])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final file = File('my_toko.sqlite');
      return NativeDatabase(file);
    });
  }
}