import 'package:drift/drift.dart';
import 'package:project_toko/Sales/model/sales_with_sale_items.dart';
import 'package:project_toko/database/database.dart';

part 'purchase_dao.g.dart';

@DriftAccessor(tables: [Purchases, PurchaseItems, Items])
class PurchasesDao extends DatabaseAccessor<AppDatabase>
    with _$PurchasesDaoMixin {
  PurchasesDao(super.db);

  Future<List<Purchase>>
  searchByNamaByNamaInstansiByTanggalBySudahDibayar(
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
}
