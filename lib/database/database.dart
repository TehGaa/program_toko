import 'package:drift/drift.dart';
// import 'package:drift_flutter/drift_flutter.dart';
// import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:project_toko/database/item_dao.dart';

part 'database.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaItem => text().withLength(max: 99)();
  IntColumn get stokUnitTerkecil => integer()();
  TextColumn get unitTerkecil => text()();
  IntColumn get hargaItem => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class UnitConversions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().references(
    Items,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get namaUnit => text()();
  IntColumn get multiplier => integer()();
}

@DriftDatabase(tables: [Items, UnitConversions], daos: [ItemsDao])
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
