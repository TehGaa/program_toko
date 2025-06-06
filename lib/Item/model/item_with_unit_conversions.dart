import "package:project_toko/database/database.dart";

class ItemWithUnitConversions {
  final Item? item;
  final List<UnitConversion>? unitConversions;

  ItemWithUnitConversions({
    required this.item,
    required this.unitConversions 
  });
}