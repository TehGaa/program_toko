import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_toko/Sales/model/sales_with_sale_items.dart';
import 'package:project_toko/database/database.dart';

class ExcelService {
  static Future<String> exportSalesWithSaleItems(
    SalesWithSaleItems sale,
  ) async {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    var dateFormatter = DateFormat('M/d/yyyy');

    final excel = Excel.createExcel();

    final saleItems = sale.saleItems!;
    final saleItemsSize = saleItems.length;
    final sheetsNumber = (saleItemsSize + 10 - 1) ~/ 10;

    // Buat semua sheet dengan nama unik
    final sheets = <Sheet>[];
    for (int i = 0; i < sheetsNumber; i++) {
      final sheetName = 'Sheet${i + 1}';
      final sheet = excel.sheets[sheetName] ?? excel[sheetName];
      sheets.add(sheet);
    }

    int index = 1;
    int total = 0;

    for (int i = 0; i < sheetsNumber; i++) {
      final sheet = sheets[i];

      // === Tambahkan Header di Setiap Sheet ===
      sheet.appendRow([
        TextCellValue("<NAMA PERUSAHAAN>"),
        TextCellValue(""),
        TextCellValue(""),
        TextCellValue("Tanggal"),
        TextCellValue(dateFormatter.format(sale.sale!.tanggalPenjualan!)),
      ]);
      sheet.appendRow([TextCellValue("<ISI LOKASI>")]);
      sheet.appendRow([TextCellValue(sale.sale!.namaInstansi)]);
      sheet.appendRow([TextCellValue("CUSTOMER")]);
      sheet.appendRow([TextCellValue("PENJUALAN ${sale.sale!.tipePenjualan}")]);

      int identifierIndex = 1;
      // Identifiers
      if (sale.sale!.identifiers != null) {
        var identifiers = List<Map<String, dynamic>>.from(
          jsonDecode(sale.sale!.identifiers!),
        );

        for (Map<String, dynamic> identifier in identifiers) {
          sheet
              .cell(
                CellIndex.indexByColumnRow(
                  columnIndex: 3,
                  rowIndex: identifierIndex,
                ),
              )
              .value = TextCellValue(
            identifier["field"].toString(),
          );
          sheet
              .cell(
                CellIndex.indexByColumnRow(
                  columnIndex: 4,
                  rowIndex: identifierIndex,
                ),
              )
              .value = TextCellValue(
            identifier["isi"].toString(),
          );
          identifierIndex += 1;
        }
      }
      sheet
          .cell(
            CellIndex.indexByColumnRow(
              columnIndex: 3,
              rowIndex: identifierIndex,
            ),
          )
          .value = TextCellValue(
        "Hal : ${i + 1}",
      );

      sheet.appendRow([TextCellValue(' ')]);
      sheet.appendRow([TextCellValue(' ')]);

      // Tabel Header
      sheet.appendRow([
        TextCellValue("No"),
        TextCellValue("Qty"),
        TextCellValue(""),
        TextCellValue("Keterangan"),
        TextCellValue("Harga"),
        TextCellValue("Total"),
      ]);

      // Ambil item untuk sheet ini
      final start = i * 10;
      final end = (start + 10 > saleItemsSize) ? saleItemsSize : (start + 10);
      final currentItems = saleItems.sublist(start, end);

      for (final saleItem in currentItems) {
        final itemTotal =
            saleItem.harga * saleItem.jumlah;
        sheet.appendRow([
          TextCellValue(index.toString()),
          TextCellValue(saleItem.jumlah.toString()),
          TextCellValue(saleItem.unit.toUpperCase()),
          TextCellValue(saleItem.namaItem.toUpperCase()),
          TextCellValue(formatCurrency.format(saleItem.harga)),
          TextCellValue(formatCurrency.format(itemTotal)),
        ]);
        total += itemTotal;
        index++;
      }

      // Tambahkan tanda tangan hanya di sheet terakhir
      if (i == sheetsNumber - 1) {
        sheet.appendRow([]);
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
      }

      // Auto-fit kolom
      for (int c = 0; c <= 5; c++) {
        sheet.setColumnAutoFit(c);
      }
    }

    // Simpan file
    final dir = await getApplicationDocumentsDirectory();
    final baseName = '${sale.sale!.namaPenjualan}-${sale.sale!.namaInstansi}'
        .replaceAll(RegExp(r'[\\/:"*?<>|]+'), '-');
    final extension = '.xlsx';
    var fileName = '$baseName$extension';
    var filePath = '${dir.path}/$fileName';

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
