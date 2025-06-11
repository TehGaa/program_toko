import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_toko/Purchases/page/purchases_detail_page.dart';
import 'package:project_toko/appbar.dart';
import 'package:project_toko/database/database.dart';
import 'package:project_toko/drawer.dart';
import 'package:project_toko/database/database_instance.dart' as globals;
import 'package:drift/drift.dart' as drift;

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({super.key});

  @override
  State<StatefulWidget> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  Timer? _debounce;
  Future<List<Purchase>>? _itemsFuture;
  final _formKey = GlobalKey<FormState>();

  //search controllers
  final _searchByNamaPembelianController = TextEditingController();
  final _searchByNamaInstansiController = TextEditingController();
  final _searchByTanggalPembelianController = TextEditingController();
  final _searchBySudahDibayarController = TextEditingController();
  final _searchByTipePembelianController = TextEditingController();

  //tambah pembelian controllers
  final _namaPembelianController = TextEditingController();
  final _namaInstansiController = TextEditingController();
  final _tanggalPembelianController = TextEditingController();
  final _tipePembelianController = TextEditingController(text: "KREDIT");
  final _sudahDibayarController = TextEditingController(text: "BELUM");

  @override
  void initState() {
    super.initState();
    _loadPurchases();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchByNamaPembelianController.dispose();
    _searchByNamaInstansiController.dispose();
    _searchByTanggalPembelianController.dispose();
    _searchBySudahDibayarController.dispose();
    _searchByTipePembelianController.dispose();
    _namaPembelianController.dispose();
    _namaInstansiController.dispose();
    _tanggalPembelianController.dispose();
    _tipePembelianController.dispose();
    _sudahDibayarController.dispose();
    super.dispose();
  }

  void clearSearchFields() {
    _searchByNamaPembelianController.clear();
    _searchByNamaInstansiController.clear();
    _searchBySudahDibayarController.clear();
    _searchByTanggalPembelianController.clear();
    _searchByTipePembelianController.clear();
  }

  void _loadPurchases() {
    setState(() {
      _itemsFuture = globals.database.select(globals.database.purchases).get();
    });
  }

  void _searchPurchases() {
    setState(() {
      var namaPembelian = _searchByNamaPembelianController.text;
      var namaInstansi = _searchByNamaInstansiController.text;
      var tipePembelian = _searchByTipePembelianController.text == ""
          ? null
          : _searchByTipePembelianController.text;

      String? tanggalPembelian;
      if (_searchByTanggalPembelianController.text != "") {
        tanggalPembelian = _searchByTanggalPembelianController.text;
      }
      bool? sudahDibayar;
      if (_searchBySudahDibayarController.text.compareTo("") != 0) {
        sudahDibayar = _searchBySudahDibayarController.text == "SUDAH";
      }

      _itemsFuture = globals.database.purchasesDao
          .searchByNamaByNamaInstansiByTanggalBySudahDibayar(
            namaPembelian,
            namaInstansi,
            tanggalPembelian,
            sudahDibayar,
            tipePembelian,
          );
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final namaPembelian = _namaPembelianController.text;
      final namaInstansi = _namaInstansiController.text;
      final tipePembelian = _tipePembelianController.text;
      final tanggalPembelian = DateTime.parse(_tanggalPembelianController.text);
      final sudahDibayar = _sudahDibayarController.text == "SUDAH"
          ? true
          : false;

      globals.database
          .into(globals.database.purchases)
          .insert(
            PurchasesCompanion.insert(
              namaPembelian: namaPembelian,
              namaInstansi: namaInstansi,
              tipePembelian: drift.Value(tipePembelian),
              sudahDibayar: drift.Value(sudahDibayar),
              tanggalPembelian: drift.Value(tanggalPembelian),
            ),
          );

      Navigator.pop(context); // tutup dialog
      _loadPurchases();

      _searchByNamaPembelianController.clear();
      _searchByNamaInstansiController.clear();
      _searchByTanggalPembelianController.clear();
      _searchBySudahDibayarController.clear();
      _tipePembelianController.clear();
    }
  }

  Future<bool> _deletePurchase(Purchase purchase) async {
    final query = globals.database.select(globals.database.purchaseItems);
    query.where((tbl) => tbl.purchaseId.equals(purchase.id));
    final purchaseItems = await query.get();

    if (purchaseItems.isNotEmpty) {
      return false; // hanya return status
    }

    await globals.database.delete(globals.database.purchases).delete(purchase);
    _loadPurchases();
    return true;
  }

  Future<void> _selectTanggalPembelian() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );

    if (picked != null) {
      setState(() {
        _tanggalPembelianController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Widget _buildSearchBar() {
    return Row(
      spacing: 10,
      children: [
        ElevatedButton(
          child: Text("Tambah Pembelian Baru"),
          onPressed: () {
            openTambahPurchasesDialog();
          },
        ),
        Expanded(
          child: TextField(
            controller: _searchByNamaPembelianController,
            decoration: InputDecoration(
              hintText: 'Cari nama pembelian...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();

              _debounce = Timer(const Duration(milliseconds: 700), () {
                _searchPurchases();
              });
            },
          ),
        ),
        Expanded(
          child: TextField(
            controller: _searchByNamaInstansiController,
            decoration: InputDecoration(
              hintText: 'Cari nama instansi...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();

              _debounce = Timer(const Duration(milliseconds: 700), () {
                _searchPurchases();
              });
            },
          ),
        ),
        Expanded(
          child: TextField(
            controller: _searchByTanggalPembelianController,
            decoration: InputDecoration(
              hintText: 'Tanggal pembelian...',
              prefixIcon: Icon(Icons.calendar_today),
              filled: true,
            ),
            readOnly: true,
            onTap: () {
              _searchDate();
            },
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _searchBySudahDibayarController.text,
              onChanged: (value) {
                setState(() {
                  _searchBySudahDibayarController.text = value ?? "BELUM";
                });
                _searchPurchases();
              },
              items: ["", "SUDAH", "BELUM"].map((item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipe Pembelian',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _searchByTipePembelianController.text,
              onChanged: (value) {
                setState(() {
                  _searchByTipePembelianController.text = value ?? "KREDIT";
                });
                _searchPurchases();
              },
              items: ["", "KREDIT", "CASH"].map((item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPurchases() {
    return Expanded(
      child: FutureBuilder<List<Purchase>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada item'));
          } else {
            final items = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(color: Colors.black),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
                  5: FlexColumnWidth(1),
                },
                children: [
                  // Header row
                  const TableRow(
                    decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Nama Pembelian",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Nama Instansi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Tipe Jual",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Tanggal Pembelian",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Status Bayar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Operasi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Dynamic rows
                  ...items.map((item) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            item.namaPembelian.toUpperCase() ?? "-",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            item.namaInstansi.toUpperCase() ?? "-",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            item.tipePembelian.toUpperCase() ?? "-",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            item.tanggalPembelian.toString().split(" ")[0] ??
                                "-",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            item.sudahDibayar == true ? "Sudah" : "Belum",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PurchasesDetailPage(item.id),
                                      ),
                                    );
                                  },
                                  child: Text('Detil'),
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  openDeleteConfirmationDialog(item);
                                },
                                child: Text('Hapus'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Halaman Pembelian"),
      drawer: ProjectTokoDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [_buildSearchBar(), _buildPurchases()],
      ),
    );
  }

  Future<void> _searchDate() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );

    if (picked != null) {
      final start = picked.start.toString().split(" ")[0];
      final end = picked.end.toString().split(" ")[0];

      setState(() {
        _searchByTanggalPembelianController.text = "$start/$end";
        _searchPurchases();
      });
    } else {
      setState(() {
        _searchByTanggalPembelianController.clear();
        _searchPurchases();
      });
    }
  }

  Future openDeleteConfirmationDialog(Purchase item) => showDialog(
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
            onPressed: () async {
              // Tutup dialog konfirmasi dulu
              if (context.mounted && Navigator.of(context).canPop()) {
                Navigator.pop(context);
              }

              final result = await _deletePurchase(item);

              if (!context.mounted) return;

              if (!result) {
                // Tampilkan peringatan jika gagal
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Warning'),
                    content: Text(
                      'Tidak bisa menghapus penjualan karena masih ada item penjualan',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text("Hapus"),
          ),
        ],
      );
    },
  );

  Future openTambahPurchasesDialog() =>
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Tambah Pembelian Baru"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formKey,

                        child: Column(
                          children: [
                            TextFormField(
                              controller: _namaPembelianController,
                              decoration: InputDecoration(
                                label: Text("Nama Pembelian"),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama Pembelian tidak boleh kosong!';
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
                                labelText: "Tipe Pembelian",
                              ),
                              value: _tipePembelianController.text,
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
                                _tipePembelianController.text =
                                    value ?? "KREDIT";
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Status Pembelian tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _tanggalPembelianController,
                              decoration: InputDecoration(
                                hintText: 'Tanggal Pembelian...',
                                labelText: "Tanggal Pembelian",
                                prefixIcon: Icon(Icons.calendar_today),
                                filled: true,
                              ),
                              readOnly: true,
                              onTap: () {
                                _selectTanggalPembelian();
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tanggal Pembelian tidak boleh kosong!';
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
                                  return 'Status Pembelian tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                ElevatedButton(
                                  child: Text('Submit'),
                                  onPressed: () {
                                    _submitForm();
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
        _namaPembelianController.clear();
        _namaInstansiController.clear();
        _tanggalPembelianController.clear();
        _sudahDibayarController.text = "BELUM";
        _tipePembelianController.text = "KREDIT";

        clearSearchFields();
      });
}
