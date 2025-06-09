import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_toko/Sales/model/sales_with_sale_items.dart';
import 'package:excel/excel.dart';
import 'dart:io';

import 'package:project_toko/database/database.dart';

class ExcelService {
  static Future<String> exportSalesWithSaleItems(SalesWithSaleItems sale) async {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    final excel = Excel.createExcel();
    final sheet = excel["Sheet1"];

    sheet.appendRow([
      TextCellValue("<NAMA PERUSAHAAN>"),
      TextCellValue(""),
      TextCellValue(""),
      TextCellValue("Tanggal"),
      TextCellValue(sale.sale!.tanggalPenjualan.toString().split(" ")[0]),
    ]);
    sheet.appendRow([TextCellValue("<ISI LOKASI>")]);
    sheet.appendRow([TextCellValue(sale.sale!.namaInstansi)]);

    var identifiers = List<Map<String, dynamic>>.from(
      jsonDecode(sale.sale!.identifiers!),
    );

    int identifierIndex = 0;
    for (Map<String, dynamic> identifier in identifiers) {
      sheet
              .cell(
                CellIndex.indexByColumnRow(
                  columnIndex: 5,
                  rowIndex: identifierIndex,
                ),
              )
              .value =
          identifier["field"];
      sheet
              .cell(
                CellIndex.indexByColumnRow(
                  columnIndex: 5,
                  rowIndex: identifierIndex,
                ),
              )
              .value =
          identifier["isi"];
    }

    sheet.appendRow([TextCellValue(' ')]);
    sheet.appendRow([TextCellValue(' ')]);
    sheet.appendRow([
      TextCellValue("No"),
      TextCellValue("Qty"),
      TextCellValue(""),
      TextCellValue("Keterangan"),
      TextCellValue("Harga"),
      TextCellValue("Total"),
    ]);

    int index = 1;
    int total = 0;
    for (SaleItem saleItem in sale.saleItems!) {
      sheet.appendRow([
        TextCellValue(index.toString()),
        TextCellValue(saleItem.jumlah.toString()),
        TextCellValue(saleItem.unit.toUpperCase()),
        TextCellValue(saleItem.namaItem.toUpperCase()),
        TextCellValue(saleItem.harga.toString()),
        TextCellValue(
          (saleItem.harga * saleItem.jumlah * saleItem.multiplier).toString(),
        ),
      ]);
      total += saleItem.harga * saleItem.jumlah * saleItem.multiplier;
    }

    sheet.appendRow([
      TextCellValue(""),
      TextCellValue(""),
      TextCellValue(""),
      TextCellValue("--------------->"),
      TextCellValue("TOTAL"),
      TextCellValue(formatCurrency.format(total)),
    ]);

    sheet.appendRow([TextCellValue("Diterima Oleh,")]);
    sheet.appendRow([TextCellValue(' ')]);
    sheet.appendRow([TextCellValue(' ')]);
    sheet.appendRow([TextCellValue("(----------------)")]);
    sheet.appendRow([TextCellValue("Nama Jelas")]);

    sheet.setColumnAutoFit(0);
    sheet.setColumnAutoFit(1);
    sheet.setColumnAutoFit(2);
    sheet.setColumnAutoFit(3);
    sheet.setColumnAutoFit(4);

    final dir = await getApplicationDocumentsDirectory();
    final baseName = '${sale.sale!.namaPenjualan}-${sale.sale!.namaInstansi}';
    final extension = '.xlsx';
    var fileName = '$baseName$extension';
    var filePath =
        '${dir.path}/${sale.sale!.namaPenjualan}-${sale.sale!.namaInstansi}.xlsx';

    int counter = 1;
    while (await File(filePath).exists()) {
      fileName = "$baseName ($counter)$extension";
      filePath = '${dir.path}/$fileName';
      counter++;
    }
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    return fileName;
  }
}
