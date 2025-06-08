import 'package:project_toko/database/database.dart';

class SalesWithSaleItems {
  final Sale? sale;
  final List<SaleItem>? saleItems;

  SalesWithSaleItems({
    required this.sale,
    required this.saleItems
  });
}