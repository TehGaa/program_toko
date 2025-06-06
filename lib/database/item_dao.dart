import 'package:drift/drift.dart';
import 'package:project_toko/database/database.dart';
import 'package:project_toko/Item/model/item_with_unit_conversions.dart';

part 'item_dao.g.dart';

@DriftAccessor(tables: [Items, UnitConversions])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(super.db);

  Future<List<ItemWithUnitConversions>> searchByName(String keyword) async {
    final searchedItems = await (select(
      items,
    )..where((tbl) => tbl.namaItem.like('%$keyword%'))).get();
    final result = <ItemWithUnitConversions>[];

    if (searchedItems.isNotEmpty) {
      for (final item in searchedItems) {
        final unitConversions = await (select(
          db.unitConversions,
        )..where((uc) => uc.itemId.equals(item.id))).get();
        result.add(
          ItemWithUnitConversions(item: item, unitConversions: unitConversions),
        );
      }
    }
    print(result);
    return result;
  }

  Future<List<ItemWithUnitConversions>> getAllItemsWithUnitConversions() async {
    final itemList = await select(db.items).get();
    final result = <ItemWithUnitConversions>[];

    for (final item in itemList) {
      final unitConversions = await (select(
        db.unitConversions,
      )..where((uc) => uc.itemId.equals(item.id))).get();

      result.add(
        ItemWithUnitConversions(item: item, unitConversions: unitConversions),
      );
    }
    return result;
  }

  Future<void> insertItemWithConversions({
    required String namaItem,
    required int stokUnitTerkecil,
    required String unitTerkecil,
    required int hargaItem,
    List<UnitConversionsCompanion>? conversions,
  }) {
    return transaction(() async {
      //tambah item baru
      final itemId = await into(db.items).insert(
        ItemsCompanion.insert(
          namaItem: namaItem,
          stokUnitTerkecil: stokUnitTerkecil,
          unitTerkecil: unitTerkecil,
          hargaItem: hargaItem,
        ),
      );
      //tambah semua unit conversion terkait
      if (conversions != null) {
        for (final conversion in conversions) {
          await into(
            db.unitConversions,
          ).insert(conversion.copyWith(itemId: Value(itemId)));
        }
      }
    });
  }
}
