import 'package:drift/drift.dart';
import 'package:project_toko/Sales/model/sales_with_sale_items.dart';
import 'package:project_toko/database/database.dart';

part 'sales_dao.g.dart';

@DriftAccessor(tables: [Sales, SaleItems, Items])
class SalesDao extends DatabaseAccessor<AppDatabase> with _$SalesDaoMixin {
  SalesDao(super.db);

  Future<List<SalesWithSaleItems>>
  searchByNamaByNamaInstansiByTanggalBySudahDibayar(
    String? namaPenjualan,
    String? namaInstansi,
    String? tanggalPenjualan,
    bool? sudahDibayar,
  ) async {
    final query = select(db.sales);
    if (namaPenjualan != null && namaPenjualan != "") {
      query.where((tbl) => tbl.namaPenjualan.like('%$namaPenjualan%'));
    }
    if (namaInstansi != null && namaInstansi != "") {
      query.where((tbl) => tbl.namaInstansi.like('%$namaInstansi%'));
    }
    if (tanggalPenjualan != null) {
      final tanggalPenjualanStart = DateTime.parse(
        tanggalPenjualan.split("/")[0],
      );
      final tanggalPenjualanEnd = DateTime.parse(
        tanggalPenjualan.split("/")[1],
      );

      final awalHari = DateTime(
        tanggalPenjualanStart.year,
        tanggalPenjualanStart.month,
        tanggalPenjualanStart.day,
      );
      final akhirHari = tanggalPenjualanEnd
          .add(Duration(days: 1))
          .subtract(Duration(seconds: 1));

      query.where(
        (tbl) =>
            tbl.tanggalPenjualan.isBiggerOrEqualValue(awalHari) &
            tbl.tanggalPenjualan.isSmallerOrEqualValue(akhirHari),
      );
    }
    if (sudahDibayar != null) {
      query.where((tbl) => tbl.sudahDibayar.equals(sudahDibayar));
    }
    query.orderBy([
      (u) =>
          OrderingTerm(expression: u.tanggalPenjualan, mode: OrderingMode.desc),
    ]);

    final searchedSales = await query.get();

    final result = <SalesWithSaleItems>[];

    if (searchedSales.isNotEmpty) {
      for (final sale in searchedSales) {
        final saleItems = await (select(
          db.saleItems,
        )..where((uc) => uc.saleId.equals(sale.id))).get();
        result.add(SalesWithSaleItems(sale: sale, saleItems: saleItems));
      }
    }

    return result;
  }

  Future<List<SaleItem>> searchByNameBySaleId(
    String keyword,
    int saleId,
  ) async {
    final query = (select(saleItems)
      ..where(
        (tbl) => tbl.namaItem.like('%$keyword%') & tbl.saleId.equals(saleId),
      ));
    query.orderBy([
      (tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc),
    ]);
    final searchedItems = await query.get();

    return searchedItems;
  }

  Future<List<SalesWithSaleItems>> getAllSalesWithSaleItems() async {
    final query = select(db.sales)
      ..orderBy([
        (tbl) => OrderingTerm(
          expression: tbl.tanggalPenjualan,
          mode: OrderingMode.desc,
        ),
      ]);
    final salesList = await query.get();
    final result = <SalesWithSaleItems>[];

    for (final sale in salesList) {
      final saleItems = await (select(
        db.saleItems,
      )..where((uc) => uc.saleId.equals(sale.id))).get();

      result.add(SalesWithSaleItems(sale: sale, saleItems: saleItems));
    }
    return result;
  }

  Future<SalesWithSaleItems> getSalesWithSaleItemsBySaleId(int saleId) async {
    final query = select(db.sales)
      ..orderBy([
        (tbl) => OrderingTerm(
          expression: tbl.tanggalPenjualan,
          mode: OrderingMode.desc,
        ),
      ]);
    query.where((tbl) => tbl.id.equals(saleId));
    final sale = await query.getSingleOrNull();
    SalesWithSaleItems result = SalesWithSaleItems(sale: null, saleItems: null);

    if (sale != null) {
      final saleItems = await (select(
        db.saleItems,
      )..where((uc) => uc.saleId.equals(sale.id))).get();

      result = SalesWithSaleItems(sale: sale, saleItems: saleItems);
    }

    return result;
  }

  Future<void> insertSaleWithSaleItems({
    required String namaPenjualan,
    required String namaInstansi,
    String? identifiers,
    bool? sudahDibayar,
    DateTime? tanggalPenjualan,
    DateTime? tenggatWaktu,
    List<SaleItemsCompanion>? saleItems,
  }) {
    return transaction(() async {
      //tambah item baru
      final saleId = await into(db.sales).insert(
        SalesCompanion.insert(
          namaPenjualan: namaPenjualan.toUpperCase(),
          namaInstansi: namaInstansi.toUpperCase(),
          identifiers: Value(identifiers),
          sudahDibayar: Value(sudahDibayar ?? false),
          tanggalPenjualan: Value(tanggalPenjualan),
          tenggatWaktu: Value(tenggatWaktu),
        ),
      );
      //tambah semua unit conversion terkait
      if (saleItems != null) {
        for (final saleItem in saleItems) {
          await into(
            db.saleItems,
          ).insert(saleItem.copyWith(saleId: Value(saleId)));
        }
      }
    });
  }

  Future<List<Item>> getAvailableItemsNotInSale(int saleId) async {
    // Ambil Sale beserta SaleItems
    final saleWithItems = await db.salesDao.getSalesWithSaleItemsBySaleId(
      saleId,
    );

    // Ambil nama-nama item yang sudah ada
    final existedNamaItems = <String>[];
    for (final saleItem in saleWithItems.saleItems ?? []) {
      existedNamaItems.add(saleItem.namaItem);
    }

    final query = select(db.items)
      ..where((tbl) => tbl.stokUnitTerkecil.isBiggerThanValue(0));

    if (existedNamaItems.isNotEmpty) {
      query.where(
        (tbl) => tbl.namaItem.upper().isNotIn(
          existedNamaItems.map((e) => e.toUpperCase()),
        ),
      );
    }

    return query.get();
  }

  Future<void> deleteSaleItemAndUpdateStock(int saleItemId) async {
    return transaction(() async {
      final saleItem = await (select(
        saleItems,
      )..where((s) => s.id.equals(saleItemId))).getSingleOrNull();

      if (saleItem == null) {
        throw Exception("SaleItem dengan ID $saleItemId tidak ditemukan.");
      }

      final item =
          await (select(items)..where(
                (i) =>
                    i.namaItem.upper().equals(saleItem.namaItem.toUpperCase()),
              ))
              .getSingleOrNull();

      if (item != null) {
        final updatedStock =
            item.stokUnitTerkecil + (saleItem.jumlah * saleItem.multiplier);

        await (update(items)..where((i) => i.id.equals(item.id))).write(
          ItemsCompanion(
            stokUnitTerkecil: Value(updatedStock),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      await (delete(saleItems)..where((s) => s.id.equals(saleItemId))).go();
    });
  }
}
