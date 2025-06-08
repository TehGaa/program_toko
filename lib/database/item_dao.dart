import 'package:drift/drift.dart';
import 'package:project_toko/database/database.dart';

part 'item_dao.g.dart';

@DriftAccessor(tables: [Items])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(super.db);

  Future<List<Item>> searchByName(String keyword) async {
    final query = (select(
      items,
    )..where((tbl) => tbl.namaItem.like('%$keyword%')));
    query.orderBy([
      (tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc),
    ]);
    final searchedItems = await query.get();

    return searchedItems;
  }
}
