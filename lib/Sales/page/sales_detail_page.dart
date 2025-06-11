import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:project_toko/Sales/model/sales_with_sale_items.dart';
import 'package:project_toko/appbar.dart';
import 'package:project_toko/database/database.dart';
import 'package:project_toko/drawer.dart';
import 'package:intl/intl.dart';
import 'package:project_toko/database/database_instance.dart' as globals;
import 'package:project_toko/util/excel_service.dart';

class SalesDetailPage extends StatefulWidget {
  final int saleId;

  const SalesDetailPage(this.saleId, {super.key});

  @override
  State<StatefulWidget> createState() => _SalesDetailPageState();
}

class _SalesDetailPageState extends State<SalesDetailPage> {
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  Future<SalesWithSaleItems>? _sale;
  Future<List<SaleItem>>? _saleItems;

  final _formKey = GlobalKey<FormState>();
  Timer? _debounce;

  final _namaPenjualanController = TextEditingController();
  final _namaInstansiController = TextEditingController();
  final _tanggalPenjualanController = TextEditingController();
  final _tenggatPenjualanController = TextEditingController();
  final _sudahDibayarController = TextEditingController(text: "BELUM");
  final _tipePenjualanController = TextEditingController(text: "KREDIT");

  final _namaItemController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _hargaController = TextEditingController();
  final _unitTerkecilController = TextEditingController();
  final _unitController = TextEditingController();
  final _multiplierController = TextEditingController();

  final _searchController = TextEditingController();

  // final _formatterMaxJumlahItem = MaxValueInputFormatter();
  // final _formatterMinHargaItem = MinValueInputFormatter();

  var isItemSelected = false;
  var isKonversiSelected = false;
  var maxJumlahItem = 0;
  var minHargaItem = 0;
  var totalHargaItem = 0;

  var dropdownUnit = <Map<String, dynamic>>[];

  final List<Map<String, TextEditingController>> _identifierControllers = [];
  Future<List<Item>>? _items;
  late Item? itemTerpilih;

  @override
  void initState() {
    super.initState();
    _loadSales();
    _loadItems();
  }

  @override
  void dispose() {
    _namaPenjualanController.dispose();
    _namaInstansiController.dispose();
    _tanggalPenjualanController.dispose();
    _tenggatPenjualanController.dispose();
    _sudahDibayarController.dispose();
    _tipePenjualanController.dispose();
    _namaItemController.dispose();
    _jumlahController.dispose();
    _hargaController.dispose();
    _unitTerkecilController.dispose();
    _unitController.dispose();
    _multiplierController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadSales() {
    setState(() {
      _sale = globals.database.salesDao.getSalesWithSaleItemsBySaleId(
        widget.saleId,
      );
      final query = globals.database.select(globals.database.saleItems);
      query.where((u) => u.saleId.equals(widget.saleId));
      _saleItems = query.get();
    });
  }

  void _loadItems() {
    setState(() {
      _items = globals.database.salesDao.getAvailableItemsNotInSale(
        widget.saleId,
      );
    });
  }

  void _searchSaleItems(String keyword) {
    if (keyword.isEmpty) {
      _loadSales();
    } else {
      setState(() {
        _saleItems = globals.database.salesDao.searchByNameBySaleId(
          keyword,
          widget.saleId,
        );
      });
    }
  }

  void _addNewIdentifierField() {
    setState(() {
      _identifierControllers.add({
        'field': TextEditingController(),
        'isi': TextEditingController(),
      });
    });
  }

  void _removeIdentifierField(int index) {
    setState(() {
      _identifierControllers[index]['field']!.dispose();
      _identifierControllers[index]['isi']!.dispose();
      _identifierControllers.removeAt(index);
    });
  }

  void _ubahSale(SalesWithSaleItems sale) {
    if (_formKey.currentState!.validate()) {
      final namaPenjualan = _namaPenjualanController.text;
      final namaInstansi = _namaInstansiController.text;
      final tipePenjualan = _tipePenjualanController.text;
      final tanggalPenjualan = DateTime.parse(_tanggalPenjualanController.text);
      final tenggatWaktu = DateTime.parse(_tenggatPenjualanController.text);
      final sudahDibayar = _sudahDibayarController.text == "SUDAH"
          ? true
          : false;

      final identifiers = _identifierControllers.map((map) {
        return {
          "field": map["field"]!.text.toUpperCase(),
          "isi": map["isi"]!.text.toUpperCase(),
        };
      }).toList();

      final jsonIdentifier = jsonEncode(identifiers);

      final updatedSale = SalesCompanion.insert(
        id: drift.Value(sale.sale!.id),
        namaPenjualan: namaPenjualan,
        namaInstansi: namaInstansi,
        tipePenjualan: drift.Value(tipePenjualan),
        tanggalPenjualan: drift.Value(tanggalPenjualan),
        tenggatWaktu: drift.Value(tenggatWaktu),
        sudahDibayar: drift.Value(sudahDibayar),
        identifiers: drift.Value(jsonIdentifier),
      );
      globals.database.update(globals.database.sales).replace(updatedSale);

      Navigator.pop(context); // tutup dialog
      _loadSales();
    }
  }

  void _tambahSaleItem() {
    if (_formKey.currentState!.validate()) {
      String cleanedHarga = _hargaController.text.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );

      int hargaInt = int.parse(cleanedHarga);

      globals.database
          .update(globals.database.items)
          .replace(
            ItemsCompanion.insert(
              id: drift.Value(itemTerpilih!.id),
              namaItem: itemTerpilih!.namaItem,
              stokUnitTerkecil:
                  itemTerpilih!.stokUnitTerkecil -
                  (int.parse(_jumlahController.text) *
                      int.parse(_multiplierController.text)),
              unitTerkecil: itemTerpilih!.unitTerkecil,
              hargaItem: itemTerpilih!.hargaItem,
              konversi: itemTerpilih!.konversi,
              updatedAt: drift.Value(DateTime.now()),
            ),
          );

      globals.database
          .into(globals.database.saleItems)
          .insert(
            SaleItemsCompanion.insert(
              namaItem: _namaItemController.text.toUpperCase(),
              jumlah: int.parse(_jumlahController.text),
              harga: hargaInt,
              unitTerkecil: _unitTerkecilController.text.toUpperCase(),
              unit: _unitController.text.toUpperCase(),
              multiplier: int.parse(_multiplierController.text),
              saleId: widget.saleId,
            ),
          );
      Navigator.pop(context);
      _loadSales();
      _loadItems();
      itemTerpilih = null;
    }
  }

  void _deleteSaleItem(SaleItem saleItem) {
    globals.database.salesDao.deleteSaleItemAndUpdateStock(saleItem.id);
    _searchController.clear();
    Navigator.pop(context);
    _loadSales();
    _loadItems();
  }

  Widget infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Expanded(
            child: Text(
              value?.toUpperCase() ?? "",
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(SalesWithSaleItems sale, List<dynamic> identifiers) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info Penjualan
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "INFO PENJUALAN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                textAlign: TextAlign.center,
              ),
              Divider(),
              infoRow("NAMA PENJUALAN", sale.sale?.namaPenjualan),
              infoRow("NAMA INSTANSI", sale.sale?.namaInstansi),
              infoRow("TIPE PENJUALAN", sale.sale?.tipePenjualan),
              infoRow(
                "SUDAH DIBAYAR",
                sale.sale?.sudahDibayar == true ? "SUDAH" : "BELUM",
              ),
              infoRow(
                "TANGGAL PENJUALAN",
                sale.sale?.tanggalPenjualan.toString().split(" ")[0],
              ),
              infoRow(
                "TENGGAT WAKTU",
                sale.sale?.tenggatWaktu.toString().split(" ")[0],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Info Detail (Identifiers)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "INFO DETAIL",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              Divider(),
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            identifier['isi']?.toUpperCase() ?? "",
                            style: TextStyle(fontSize: 17),
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
    );
  }

  Widget _buildButtonSection(SalesWithSaleItems sale) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _openUpdateInfoSale(sale),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFC107),
              foregroundColor: Colors.black,
            ),
            child: Text("Ubah Info Penjualan"),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _openTambahSaleItemDialog(sale.sale!);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(
              "Tambah Item Penjualan",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              saveExcel(context, sale);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              "Export ke Excel",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemSection() {
    return FutureBuilder<List<SaleItem>>(
      future: _saleItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Belum ada item'));
        }

        final items = snapshot.data!;
        var totalSaleItem = 0;
        for (SaleItem saleItem in snapshot.data!) {
          totalSaleItem +=
              saleItem.harga * saleItem.jumlah * saleItem.multiplier;
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text(
                  "ITEM PENJUALAN (TOTAL: ${formatCurrency.format(totalSaleItem)})",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                Divider(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: Table(
                      border: TableBorder.all(color: Colors.black),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "NAMA ITEM",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "JUMLAH ITEM",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "UNIT",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "HARGA ITEM",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "TOTAL HARGA ITEM",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "OPERASI",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        ...items.map((item) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  item.namaItem.toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  item.jumlah.toString(),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  '${item.unit} (${item.multiplier}${item.unitTerkecil})',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  '${formatCurrency.format(item.harga)} per ${item.unitTerkecil}',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  formatCurrency.format(
                                    item.harga * item.multiplier * item.jumlah,
                                  ),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Expanded(
                                    //   child: ElevatedButton(
                                    //     onPressed: () {
                                    //       // openUpdateItemDialog(item);
                                    //     },
                                    //     child: Text(
                                    //       "Ubah",
                                    //       style: TextStyle(fontSize: 17),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          openDeleteConfirmationDialog(item);
                                        },
                                        child: Text(
                                          "Hapus",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Halaman Detail Penjualan"),
      drawer: ProjectTokoDrawer(),
      body: FutureBuilder<SalesWithSaleItems>(
        future: _sale,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Data tidak ditemukan'));
          }

          final sale = snapshot.data!;
          final identifiers =
              jsonDecode(sale.sale?.identifiers ?? "[]") as List<dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection(sale, identifiers),
                const SizedBox(height: 24),
                _buildButtonSection(sale),
                const SizedBox(height: 24),
                Divider(),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari nama item...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();

                    _debounce = Timer(const Duration(milliseconds: 700), () {
                      _searchSaleItems(value);
                    });
                  },
                ),
                _buildItemSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Future openDeleteConfirmationDialog(SaleItem item) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Konfirmasi Penghapusan"),
        content: Text("Apakah Anda yakin ingin menghapus item ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batalkan"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              _deleteSaleItem(item);
            },
            child: Text("Hapus"),
          ),
        ],
      );
    },
  );

  Future _openTambahSaleItemDialog(Sale sale) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Tambah Item Penjualan Baru"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _formKey,

                      child: Column(
                        children: [
                          FutureBuilder<List<Item>>(
                            future: _items, // Future<List<Item>>
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Terjadi kesalahan: ${snapshot.error}',
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text('Tidak ada item tersedia.');
                              }

                              final items = snapshot.data!;

                              return Autocomplete<String>(
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text.isEmpty) {
                                        return const Iterable<String>.empty();
                                      }
                                      return items
                                          .where(
                                            (Item item) => item.namaItem
                                                .toUpperCase()
                                                .contains(
                                                  textEditingValue.text
                                                      .toUpperCase(),
                                                ),
                                          )
                                          .map((e) => e.namaItem.toUpperCase())
                                          .toList();
                                    },
                                onSelected: (String val) {
                                  final item = items.firstWhere(
                                    (item) =>
                                        item.namaItem.toUpperCase() ==
                                        val.toUpperCase(),
                                    orElse: () => items
                                        .first, // fallback jika tidak ketemu
                                  );

                                  setState(() {
                                    _namaItemController.text = item.namaItem;
                                    isItemSelected = true;

                                    dropdownUnit
                                      ..clear()
                                      ..add({
                                        "unit": item.unitTerkecil.toUpperCase(),
                                        "multiplier": 1,
                                      });

                                    itemTerpilih = item;

                                    final konversiList =
                                        List<Map<String, dynamic>>.from(
                                          jsonDecode(item.konversi),
                                        );
                                    dropdownUnit.addAll(konversiList);

                                    _unitTerkecilController.text =
                                        item.unitTerkecil;
                                  });
                                },
                                fieldViewBuilder:
                                    (
                                      BuildContext context,
                                      TextEditingController
                                      textEditingController,
                                      FocusNode focusNode,
                                      VoidCallback onFieldSubmitted,
                                    ) {
                                      return TextFormField(
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        decoration: const InputDecoration(
                                          labelText: 'Nama Item',
                                        ),
                                        enabled: !isItemSelected,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                              );
                            },
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Unit Satuan",
                            ),
                            value: _unitController.text,
                            items: [
                              DropdownMenuItem(value: "", child: Text("")),
                              ...dropdownUnit.map((unit) {
                                return DropdownMenuItem(
                                  value: unit["unit"]!.toString(),
                                  child: Text(unit["unit"].toString()),
                                );
                              }),
                            ],
                            onChanged: (!isItemSelected || isKonversiSelected)
                                ? null
                                : (value) {
                                    if (value == "") {
                                      setState(() {
                                        _unitController.text =
                                            _unitTerkecilController.text
                                                .toUpperCase();
                                      });
                                    } else {
                                      setState(() {
                                        isKonversiSelected = true;
                                        _unitController.text = value ?? "";
                                        _multiplierController.text = "";
                                        for (Map<String, dynamic> unit
                                            in dropdownUnit) {
                                          if (unit["unit"]!
                                                  .toString()
                                                  .compareTo(
                                                    _unitController.text,
                                                  ) ==
                                              0) {
                                            _multiplierController.text =
                                                unit["multiplier"]!.toString();
                                          }
                                        }

                                        minHargaItem =
                                            itemTerpilih!.hargaItem *
                                            int.parse(
                                              _multiplierController.text,
                                            );

                                        maxJumlahItem =
                                            itemTerpilih!.stokUnitTerkecil ~/
                                            int.parse(
                                              _multiplierController.text,
                                            );
                                      });
                                    }
                                  },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Status penjualan tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _jumlahController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Jumlah Barang",
                                  ),
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.compareTo("0") == 0) {
                                      return 'Jumlah barang tidak boleh kosong!';
                                    }
                                    final valueInt = int.parse(value);
                                    if (valueInt > maxJumlahItem) {
                                      return "Jumlah barang melebihi \nstok ($maxJumlahItem ${_unitController.text})";
                                    }
                                    return null;
                                  },
                                  enabled: isItemSelected & isKonversiSelected,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ), // beri jarak sedikit antara input dan teks
                              Text(
                                "/max: $maxJumlahItem",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _hargaController,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      leadingSymbol: 'Rp ',
                                      useSymbolPadding: true,
                                      thousandSeparator:
                                          ThousandSeparator.Period,
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    label: Text("Harga Barang"),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Harga barang tidak boleh kosong!';
                                    }
                                    String cleanedValue = value.replaceAll(
                                      RegExp(r'[^0-9]'),
                                      '',
                                    );
                                    final valueInt = int.parse(cleanedValue);
                                    if (valueInt < minHargaItem) {
                                      return "Harga barang per ${_unitController.text} \ntidak boleh lebih kecil dari \n${formatCurrency.format(minHargaItem)}";
                                    }
                                    return null;
                                  },
                                  enabled: isItemSelected & isKonversiSelected,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ), // beri jarak sedikit antara input dan teks
                              Text(
                                "/min: ${formatCurrency.format(minHargaItem)}",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: Text('Tambah Item Penjualan'),
                                onPressed: () {
                                  _tambahSaleItem();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      _namaItemController.clear();
      _jumlahController.clear();
      _hargaController.clear();
      _unitTerkecilController.clear();
      _unitController.clear();
      _multiplierController.clear();
      isItemSelected = false;
      isKonversiSelected = false;
      dropdownUnit.clear();
      maxJumlahItem = 0;
      minHargaItem = 0;
      itemTerpilih = null;
      _searchController.clear();
    });
  }

  Future _openUpdateInfoSale(SalesWithSaleItems sale) {
    _namaPenjualanController.text = sale.sale?.namaPenjualan ?? "";
    _namaInstansiController.text = sale.sale?.namaInstansi ?? "";
    _tipePenjualanController.text = sale.sale?.tipePenjualan ?? "KREDIT";
    _tanggalPenjualanController.text =
        sale.sale?.tanggalPenjualan.toString().split(" ")[0] ?? "";
    _tenggatPenjualanController.text =
        sale.sale?.tenggatWaktu.toString().split(" ")[0] ?? "";
    _sudahDibayarController.text = (sale.sale?.sudahDibayar == null
        ? null
        : sale.sale!.sudahDibayar
        ? "SUDAH"
        : "BELUM")!;

    final List<Map<String, dynamic>> identifierList =
        List<Map<String, dynamic>>.from(jsonDecode(sale.sale!.identifiers!));
    if (identifierList.isEmpty) {
      _addNewIdentifierField();
    } else {
      _identifierControllers.clear();
      for (Map<String, dynamic> identifier in identifierList) {
        setState(() {
          _identifierControllers.add({
            "field": TextEditingController(text: identifier["field"]),
            "isi": TextEditingController(text: identifier["isi"]),
          });
        });
      }
    }

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Ubah Info Penjualan"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _formKey,

                      child: Column(
                        children: [
                          TextFormField(
                            controller: _namaPenjualanController,
                            decoration: InputDecoration(
                              label: Text("Nama Penjualan"),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama penjualan tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _namaInstansiController,
                            decoration: InputDecoration(
                              label: Text("Nama Instansi"),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama instansi tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: "Tipe Penjualan",
                            ),
                            value: _tipePenjualanController.text,
                            items: [
                              DropdownMenuItem(
                                value: "KREDIT",
                                child: Text("KREDIT"),
                              ),
                              DropdownMenuItem(
                                value: "CASH",
                                child: Text("CASH"),
                              ),
                            ],
                            onChanged: (value) {
                              _tipePenjualanController.text = value ?? "BELUM";
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Tipe penjualan tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _tanggalPenjualanController,
                            decoration: InputDecoration(
                              hintText: 'Tanggal penjualan...',
                              labelText: "Tanggal Penjualan",
                              prefixIcon: Icon(Icons.calendar_today),
                              filled: true,
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectTanggalPenjualan();
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Tanggal penjualan tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _tenggatPenjualanController,
                            decoration: InputDecoration(
                              hintText: 'Tenggat penjualan...',
                              labelText: "Tenggat Penjualan",
                              prefixIcon: Icon(Icons.calendar_today),
                              filled: true,
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectTenggatPenjualan();
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Tenggat waktu tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: "Status Pembayaran",
                            ),
                            value: _sudahDibayarController.text,
                            items: [
                              DropdownMenuItem(
                                value: "SUDAH",
                                child: Text("SUDAH"),
                              ),
                              DropdownMenuItem(
                                value: "BELUM",
                                child: Text("BELUM"),
                              ),
                            ],
                            onChanged: (value) {
                              _sudahDibayarController.text = value ?? "BELUM";
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Status penjualan tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Detail",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: List.generate(
                              _identifierControllers.length,
                              (index) {
                                final fieldController =
                                    _identifierControllers[index]['field']!;
                                final isiController =
                                    _identifierControllers[index]['isi']!;

                                return Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: fieldController,
                                        decoration: InputDecoration(
                                          labelText: 'Field',
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Field tidak boleh kosong!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: TextFormField(
                                        controller: isiController,
                                        decoration: InputDecoration(
                                          labelText: 'Isi',
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Isi tidak boleh kosong!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => setState(
                                        () => _removeIdentifierField(index),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text('Tambah Detail'),
                                onPressed: () {
                                  setState(() {
                                    _identifierControllers.add({
                                      'field': TextEditingController(),
                                      'isi': TextEditingController(),
                                    });
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                child: Text('Ubah'),
                                onPressed: () {
                                  _ubahSale(sale);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      for (var field in _identifierControllers) {
        field['unit']?.clear();
        field['multiplier']?.clear();
      }
      _identifierControllers.clear();

      _namaPenjualanController.clear();
      _namaInstansiController.clear();
      _tipePenjualanController.clear();
      _tanggalPenjualanController.clear();
      _tenggatPenjualanController.clear();
      _sudahDibayarController.text = "BELUM";
    });
  }

  Future<void> _selectTanggalPenjualan() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );

    if (picked != null) {
      setState(() {
        _tanggalPenjualanController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTenggatPenjualan() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );

    if (picked != null) {
      setState(() {
        _tenggatPenjualanController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> saveExcel(BuildContext context, SalesWithSaleItems sale) async {
    var fileName = await ExcelService.exportSalesWithSaleItems(sale);

    // cek apakah widget masih mounted (jika dalam State)
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sukses'),
        content: Text('File Excel berhasil disimpan dengan nama $fileName!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
