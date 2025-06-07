import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_toko/Sales/model/sales_with_sale_items.dart';
import 'package:project_toko/appbar.dart';
import 'package:project_toko/database/database.dart';
import 'package:project_toko/drawer.dart';
import 'package:intl/intl.dart';
import 'package:project_toko/database/database_instance.dart' as globals;

class SalesDetailPage extends StatefulWidget {
  final SalesWithSaleItems sale;

  const SalesDetailPage(this.sale, {super.key});

  @override
  State<StatefulWidget> createState() => _SalesDetailPageState();
}

class _SalesDetailPageState extends State<SalesDetailPage> {
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  Widget infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value?.toUpperCase() ?? "")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SalesWithSaleItems sale = widget.sale;
    List<Map<String, String>> identifiers = [];

    if (sale.sale?.identifiers != null) {
      final List<dynamic> jsonList = jsonDecode(sale.sale!.identifiers!);

      identifiers = jsonList.map<Map<String, String>>((item) {
        final map = Map<String, dynamic>.from(item);
        // pastikan semua value adalah String, kalau tidak sesuaikan sesuai tipe
        return map.map((key, value) => MapEntry(key, value.toString()));
      }).toList();
    }

    return Scaffold(
      appBar: buildAppBar(context, "Halaman Detail Penjualan"),
      drawer: ProjectTokoDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "INFO PENJUALAN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(color: Colors.grey, thickness: 1),
                      infoRow("Nama Penjualan", sale.sale?.namaPenjualan),
                      infoRow("Nama Instansi", sale.sale?.namaInstansi),
                      infoRow(
                        "Sudah Dibayar",
                        sale.sale?.sudahDibayar == true ? "SUDAH" : "BELUM",
                      ),
                      infoRow(
                        "Tanggal Penjualan",
                        sale.sale?.tanggalPenjualan.toString().split(" ")[0],
                      ),
                      infoRow(
                        "Tenggat Waktu",
                        sale.sale?.tenggatWaktu.toString().split(" ")[0],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "INFO DETAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      Divider(color: Colors.grey, thickness: 1),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: identifiers.length,
                        itemBuilder: (context, index) {
                          final identifier = identifiers[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Text(
                                  '${identifier['field']?.toUpperCase() ?? ""}: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    identifier['isi']?.toUpperCase() ?? "",
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107), // Kuning Amber
                      foregroundColor: Colors.black, // supaya tulisan jelas
                    ),
                    child: Text("Ubah Info Penjualan"),
                  ),
                ),
                SizedBox(width: 16), // spasi antar tombol
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Tambah Item Penjualan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 16), // spasi antar tombol
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "Export ke excel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "ITEM PENJUALAN",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            Expanded(
              child: Builder(
                builder: (context) {
                  final items = sale.saleItems;

                  if (items == null || items.isEmpty) {
                    return Center(
                      child: Text(
                        "Belum ada item penjualan",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final saleItem = items[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Nama Item: ${saleItem.namaItem}"),
                              Text("Total Harga Item: ${formatCurrency.format(saleItem.harga * saleItem.multiplier)}"),
                              Text("Jumlah Item: ${saleItem.jumlah} ${saleItem.unit}"),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text("Ubah"),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text("Hapus"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
