import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:intl/intl.dart';
import 'package:project_toko/appbar.dart';
import 'package:project_toko/database/database.dart';
import 'package:project_toko/drawer.dart';
import 'package:project_toko/database/database_instance.dart' as globals;
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';

class PurchasesDetailPage extends StatefulWidget {
  final int purchaseId;

  const PurchasesDetailPage(this.purchaseId, {super.key});

  @override
  State<StatefulWidget> createState() => _PurchasesDetailPageState();
}

class _PurchasesDetailPageState extends State<PurchasesDetailPage> {
  Future<Purchase>? _purchase;
  Future<List<PurchaseItem>>? _purchaseItems;
  Future<List<Item>>? _items;

  Timer? _debounce;

  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  final _namaPembelianController = TextEditingController();
  final _namaInstansiController = TextEditingController();
  final _tanggalPembelianController = TextEditingController();
  final _tipePembelianController = TextEditingController(text: "KREDIT");
  final _sudahDibayarController = TextEditingController(text: "BELUM");

  final _namaItemController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _hargaController = TextEditingController();
  final _unitTerkecilController = TextEditingController();
  final _unitController = TextEditingController();
  final _multiplierController = TextEditingController();

  var isItemSelected = false;
  var isKonversiSelected = false;
  var totalHargaItem = 0;

  var dropdownUnit = <Map<String, dynamic>>[];

  late Item? itemTerpilih;

  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _loadPurchase();
    _loadPurchaseItems();
    _loadItems();
  }

  @override
  void dispose() {
    _namaPembelianController.dispose();
    _namaInstansiController.dispose();
    _tanggalPembelianController.dispose();
    _tipePembelianController.dispose();
    _sudahDibayarController.dispose();

    _namaItemController.dispose();
    _jumlahController.dispose();
    _hargaController.dispose();
    _unitTerkecilController.dispose();
    _unitController.dispose();
    _multiplierController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadPurchase() {
    int purchaseId = widget.purchaseId;
    setState(() {
      final query = globals.database.select(globals.database.purchases);
      query.where((tbl) => tbl.id.equals(purchaseId));
      _purchase = query.getSingle();
    });
  }

  void _loadPurchaseItems() {
    int purchaseId = widget.purchaseId;
    setState(() {
      final query = globals.database.select(globals.database.purchaseItems);
      query.where((tbl) => tbl.purchaseId.equals(purchaseId));
      _purchaseItems = query.get();
    });
  }

  void _loadItems() {
    int purchaseId = widget.purchaseId;
    setState(() {
      _items = globals.database.purchasesDao.getAvailableItemsNotInPurchaseItem(
        purchaseId,
      );
    });
  }

  void _searchPurchaseItems(String keyword) {
    int purchaseId = widget.purchaseId;
    if (keyword.isEmpty) {
      _loadPurchaseItems();
    } else {
      setState(() {
        final query = globals.database.select(globals.database.purchaseItems);
        query.where(
          (tbl) =>
              tbl.purchaseId.equals(purchaseId) &
              tbl.namaItem.upper().like("%${keyword.toUpperCase()}%"),
        );
        _purchaseItems = query.get();
      });
    }
  }

  void _tambahPurchaseItem() {
    if (_formKey.currentState!.validate()) {
      String cleanedHarga = _hargaController.text.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );

      int hargaInt = int.parse(cleanedHarga);
      int jumlahInt = int.parse(_jumlahController.text);
      int multiplierInt = int.parse(_multiplierController.text);

      int hargaUnitTerkecil = (hargaInt / multiplierInt).ceil();
      int jumlahUnitTerkecil = jumlahInt * multiplierInt;

      // Konversi ke satuan terkecil
      int totalHargaBaru = hargaUnitTerkecil * jumlahUnitTerkecil;
      int jumlahBaru = jumlahUnitTerkecil;
      int totalHargaLama = itemTerpilih!.hargaItem * itemTerpilih!.stokUnitTerkecil;
      int jumlahLama = itemTerpilih!.stokUnitTerkecil;

      int rataRataHarga = ((totalHargaLama + totalHargaBaru) / (jumlahLama + jumlahBaru)).ceil();

      globals.database
          .update(globals.database.items)
          .replace(
            ItemsCompanion.insert(
              id: drift.Value(itemTerpilih!.id),
              namaItem: itemTerpilih!.namaItem,
              stokUnitTerkecil:
                  itemTerpilih!.stokUnitTerkecil +
                  (int.parse(_jumlahController.text) *
                      int.parse(_multiplierController.text)),
              unitTerkecil: itemTerpilih!.unitTerkecil,
              hargaItem: rataRataHarga,
              konversi: itemTerpilih!.konversi,
              updatedAt: drift.Value(DateTime.now()),
            ),
          );

      globals.database
          .into(globals.database.purchaseItems)
          .insert(
            PurchaseItemsCompanion.insert(
              namaItem: _namaItemController.text.toUpperCase(),
              jumlah: int.parse(_jumlahController.text),
              harga: hargaInt,
              unitTerkecil: _unitTerkecilController.text.toUpperCase(),
              unit: _unitController.text.toUpperCase(),
              multiplier: int.parse(_multiplierController.text),
              purchaseId: widget.purchaseId,
            ),
          );
      Navigator.pop(context);
      _loadPurchase();
      _loadPurchaseItems();
      _loadItems();
      itemTerpilih = null;
    }
  }

  void _deletePurchaseItem(PurchaseItem purchaseItem) {
    globals.database.purchasesDao.deletePurchaseItemAndUpdateStock(
      purchaseItem.id,
    );
    _searchController.clear();
    Navigator.pop(context);
    _loadPurchase();
    _loadPurchaseItems();
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

  Widget _buildButtonSection(Purchase purchase) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // _openUpdateInfoSale(sale);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFC107),
              foregroundColor: Colors.black,
            ),
            child: Text("Ubah Info Pembelian"),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _openTambahPurchaseItemDialog(purchase);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(
              "Tambah Item Pembelian",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 16),
        // Expanded(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       saveExcel(context, sale);
        //     },
        //     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        //     child: Text(
        //       "Export ke Excel",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildInfoSection(Purchase purchase) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "INFO PEMBELIAN",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          textAlign: TextAlign.center,
        ),
        Divider(),
        infoRow("NAMA PEMBELIAN", purchase.namaPembelian),
        infoRow("NAMA INSTANSI", purchase.namaInstansi),
        infoRow("TIPE PEMBELIAN", purchase.tipePembelian),
        infoRow(
          "SUDAH DIBAYAR",
          purchase.sudahDibayar == true ? "SUDAH" : "BELUM",
        ),
        infoRow(
          "TANGGAL PEMBELIAN",
          purchase.tanggalPembelian.toString().split(" ")[0],
        ),
      ],
    );
  }

  Widget _buildPurchaseItemsSection() {
    return FutureBuilder(
      future: _purchaseItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Belum ada item'));
        }
        final items = snapshot.data!;

        var totalPurchaseItems = 0;
        for (PurchaseItem purchaseItem in snapshot.data!) {
          totalPurchaseItems += purchaseItem.harga * purchaseItem.jumlah;
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text(
                  "ITEM PEMBELIAN (TOTAL: ${formatCurrency.format(totalPurchaseItems)})",
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
                                  '${formatCurrency.format(item.harga)} per ${item.unit}',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  formatCurrency.format(
                                    item.harga * item.jumlah,
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

  Future openDeleteConfirmationDialog(PurchaseItem item) => showDialog(
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
              _deletePurchaseItem(item);
            },
            child: Text("Hapus"),
          ),
        ],
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Halaman Detail Pembelian"),
      drawer: ProjectTokoDrawer(),
      body: FutureBuilder<Purchase>(
        future: _purchase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Data tidak ditemukan'));
          }
          final purchase = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection(purchase),
                Divider(),
                _buildButtonSection(purchase),
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
                      _searchPurchaseItems(value);
                    });
                  },
                ),
                Divider(),
                _buildPurchaseItemsSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Future _openTambahPurchaseItemDialog(Purchase purchase) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Tambah Item Pembelian Baru"),
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
                                      });
                                    }
                                  },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Status Pembelian tidak boleh kosong!';
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
                                    return null;
                                  },
                                  enabled: isItemSelected & isKonversiSelected,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ), // beri jarak sedikit antara input dan teks
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
                                    return null;
                                  },
                                  enabled: isItemSelected & isKonversiSelected,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ), // beri jarak sedikit antara input dan teks
                            ],
                          ),

                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: Text('Tambah Item Pembelian'),
                                onPressed: () {
                                  _tambahPurchaseItem();
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
      itemTerpilih = null;
      _searchController.clear();
    });
  }
}
