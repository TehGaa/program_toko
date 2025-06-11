import 'package:drift/drift.dart';
import 'package:project_toko/database/database.dart';

part 'purchase_dao.g.dart';

@DriftAccessor(tables: [Purchases, PurchaseItems, Items])
class PurchasesDao extends DatabaseAccessor<AppDatabase>
    with _$PurchasesDaoMixin {
  PurchasesDao(super.db);

  Future<List<Purchase>> searchByNamaByNamaInstansiByTanggalBySudahDibayar(
    String? namaPembelian,
    String? namaInstansi,
    String? tanggalPembelian,
    bool? sudahDibayar,
    String? tipePembelian,
  ) async {
    final query = select(db.purchases);
    if (namaPembelian != null && namaPembelian != "") {
      query.where((tbl) => tbl.namaPembelian.like('%$namaPembelian%'));
    }
    if (namaInstansi != null && namaInstansi != "") {
      query.where((tbl) => tbl.namaInstansi.like('%$namaInstansi%'));
    }
    if (tanggalPembelian != null) {
      final tanggalPembelianStart = DateTime.parse(
        tanggalPembelian.split("/")[0],
      );
      final tanggalPembelianEnd = DateTime.parse(
        tanggalPembelian.split("/")[1],
      );

      final awalHari = DateTime(
        tanggalPembelianStart.year,
        tanggalPembelianStart.month,
        tanggalPembelianStart.day,
      );
      final akhirHari = tanggalPembelianEnd
          .add(Duration(days: 1))
          .subtract(Duration(seconds: 1));

      query.where(
        (tbl) =>
            tbl.tanggalPembelian.isBiggerOrEqualValue(awalHari) &
            tbl.tanggalPembelian.isSmallerOrEqualValue(akhirHari),
      );
    }
    if (sudahDibayar != null) {
      query.where((tbl) => tbl.sudahDibayar.equals(sudahDibayar));
    }
    if (tipePembelian != null) {
      query.where(
        (tbl) => tbl.tipePembelian.upper().equals(tipePembelian.toUpperCase()),
      );
    }
    query.orderBy([
      (u) =>
          OrderingTerm(expression: u.tanggalPembelian, mode: OrderingMode.desc),
    ]);

    return await query.get();
  }

  Future<void> deletePurchaseItemAndUpdateStock(int purchaseItemId) async {
    return transaction(() async {
      final purchaseItem = await (select(
        purchaseItems,
      )..where((s) => s.id.equals(purchaseItemId))).getSingleOrNull();

      if (purchaseItem == null) {
        throw Exception(
          "purchaseItem dengan ID $purchaseItemId tidak ditemukan.",
        );
      }

      final item =
          await (select(items)..where(
                (i) => i.namaItem.upper().equals(
                  purchaseItem.namaItem.toUpperCase(),
                ),
              ))
              .getSingleOrNull();

      if (item != null) {
        var updatedStock =
            item.stokUnitTerkecil -
            (purchaseItem.jumlah * purchaseItem.multiplier);
        if (updatedStock <= 0) updatedStock = 0;

        var updatedHarga = item.hargaItem;
        if (updatedStock > 0) {
          final hargaUnitTerkecil = (purchaseItem.harga / purchaseItem.multiplier).ceil();
          final jumlahUnitTerkecil = (purchaseItem.jumlah * purchaseItem.multiplier).ceil();

          final pembilang = item.hargaItem * item.stokUnitTerkecil - hargaUnitTerkecil * jumlahUnitTerkecil;
          final penyebut = item.stokUnitTerkecil - jumlahUnitTerkecil;
          updatedHarga = (pembilang/penyebut).ceil();
        }

        await (update(items)..where((i) => i.id.equals(item.id))).write(
          ItemsCompanion(
            stokUnitTerkecil: Value(updatedStock),
            hargaItem: Value(updatedHarga),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      await (delete(
        purchaseItems,
      )..where((s) => s.id.equals(purchaseItemId))).go();
    });
  }

  Future<List<Item>> getAvailableItemsNotInPurchaseItem(int purchaseId) async {
    final subquery = selectOnly(purchaseItems)
      ..addColumns([purchaseItems.namaItem])
      ..where(purchaseItems.purchaseId.equals(purchaseId));

    final rawNames = await subquery
        .map((row) => row.read(purchaseItems.namaItem))
        .get();

    final usedNames = rawNames
        .where((name) => name != null)
        .cast<String>()
        .toList();

    if (usedNames.isEmpty) {
      return await select(items).get();
    }

    return await (select(
      items,
    )..where((tbl) => tbl.namaItem.isNotIn(usedNames))).get();
  }
}
