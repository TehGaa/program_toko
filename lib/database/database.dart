import 'package:drift/drift.dart';
// import 'package:drift_flutter/drift_flutter.dart';
// import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:project_toko/database/item_dao.dart';
import 'package:project_toko/database/sales_dao.dart';

part 'database.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaItem => text().withLength()();
  IntColumn get stokUnitTerkecil => integer()();
  TextColumn get unitTerkecil => text()();
  IntColumn get hargaItem => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
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
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaPenjualan => text()();
  TextColumn get namaInstansi => text()();
  TextColumn get identifiers => text().nullable()();
  BoolColumn get sudahDibayar => boolean().withDefault(Constant(false))();
  DateTimeColumn get tanggalPenjualan => dateTime().nullable()();
  DateTimeColumn get tenggatWaktu => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class SaleItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jumlah => integer()();
  IntColumn get harga => integer()();

  IntColumn get saleId => integer().references(
    Sales,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.cascade,
  )();
    IntColumn get itemId => integer().references(
    Items,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Items, UnitConversions, Sales, SaleItems], daos: [ItemsDao, SalesDao])
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
