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
  TextColumn get namaItem => text().unique().withLength()();
  IntColumn get stokUnitTerkecil => integer()();
  TextColumn get unitTerkecil => text()();
  IntColumn get hargaItem => integer()();
  TextColumn get konversi => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable().withDefault(currentDateAndTime)();
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
  TextColumn get namaItem => text()();
  IntColumn get jumlah => integer()();
  IntColumn get harga => integer()();
  TextColumn get unitTerkecil => text()();
  TextColumn get unit => text()();
  IntColumn get multiplier => integer()();

  IntColumn get saleId => integer().references(
    Sales,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Items, Sales, SaleItems], daos: [ItemsDao, SalesDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final file = File('my_toko.sqlite');
      return NativeDatabase(file);
    });
  }
}