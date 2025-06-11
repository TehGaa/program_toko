import 'package:flutter/material.dart';
import 'package:project_toko/Sales/model/sales_with_sale_items.dart';
import 'package:project_toko/Sales/page/sales_detail_page.dart';
import 'package:project_toko/appbar.dart';
import 'package:project_toko/drawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:project_toko/database/database_instance.dart' as globals;

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});
  @override
  State<StatefulWidget> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  Timer? _debounce;

  final _formKey = GlobalKey<FormState>();
  Future<List<SalesWithSaleItems>>? _itemsFuture;

  final _searchByNamaPenjualanController = TextEditingController();
  final _searchByNamaInstansiController = TextEditingController();
  final _searchByTanggalPenjualanController = TextEditingController();
  final _searchBySudahDibayarController = TextEditingController();
  final _searchByTipePenjualanController = TextEditingController();

  final _namaPenjualanController = TextEditingController();
  final _namaInstansiController = TextEditingController();
  final _tanggalPenjualanController = TextEditingController();
  final _tenggatPenjualanController = TextEditingController();
  final _tipePenjualanController = TextEditingController(text: "KREDIT");
  final _sudahDibayarController = TextEditingController(text: "BELUM");

  final List<Map<String, TextEditingController>> _identifierControllers = [];

  @override
  void initState() {
    super.initState();
    _loadSales();
    _addNewIdentifierField();
  }

  @override
  void dispose() {
    _searchByNamaInstansiController.dispose();
    _searchByNamaPenjualanController.dispose();
    _searchBySudahDibayarController.dispose();
    _searchByTanggalPenjualanController.dispose();

    _namaPenjualanController.dispose();
    _namaInstansiController.dispose();
    _tanggalPenjualanController.dispose();
    _tenggatPenjualanController.dispose();
    _tipePenjualanController.dispose();
    _sudahDibayarController.dispose();
    super.dispose();
  }

  void _loadSales() {
    setState(() {
      _itemsFuture = globals.database.salesDao.getAllSalesWithSaleItems();
    });
  }

  void _searchSales() {
    setState(() {
      var namaPenjualan = _searchByNamaPenjualanController.text;
      var namaInstansi = _searchByNamaInstansiController.text;
      var tipePenjualan = _searchByTipePenjualanController.text == "" ?
        null : _searchByTipePenjualanController.text;

      String? tanggalPenjualan;
      if (_searchByTanggalPenjualanController.text != "") {
        tanggalPenjualan = _searchByTanggalPenjualanController.text;
      }
      bool? sudahDibayar;
      if (_searchBySudahDibayarController.text.compareTo("") != 0) {
        sudahDibayar = _searchBySudahDibayarController.text == "SUDAH";
      }

      _itemsFuture = globals.database.salesDao
          .searchByNamaByNamaInstansiByTanggalBySudahDibayar(
            namaPenjualan,
            namaInstansi,
            tanggalPenjualan,
            sudahDibayar,
            tipePenjualan
          );
    });
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

  void _deleteSale(SalesWithSaleItems sale) {
    globals.database.delete(globals.database.sales).delete(sale.sale!);
    Navigator.pop(context);
    _loadSales();
  }

  void _submitForm() {
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

      globals.database.salesDao.insertSaleWithSaleItems(
        namaPenjualan: namaPenjualan,
        namaInstansi: namaInstansi,
        tipePenjualan: tipePenjualan,
        tanggalPenjualan: tanggalPenjualan,
        tenggatWaktu: tenggatWaktu,
        sudahDibayar: sudahDibayar,
        identifiers: jsonIdentifier,
      );

      Navigator.pop(context); // tutup dialog
      _loadSales();

      _searchByNamaPenjualanController.clear();
      _searchByNamaInstansiController.clear();
      _searchByTanggalPenjualanController.clear();
      _searchBySudahDibayarController.clear();
      _tipePenjualanController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Halaman Penjualan"),
      drawer: ProjectTokoDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton(
                  child: Text("Tambah Penjualan Baru"),
                  onPressed: () {
                    openTambahSalesDialog();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _searchByNamaPenjualanController,
                    decoration: InputDecoration(
                      hintText: 'Cari nama penjualan...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();

                      _debounce = Timer(const Duration(milliseconds: 700), () {
                        _searchSales();
                        setState(() {});
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
                        _searchSales();
                        setState(() {});
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchByTanggalPenjualanController,
                    decoration: InputDecoration(
                      hintText: 'Tanggal penjualan...',
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
                          _searchBySudahDibayarController.text =
                              value ?? "BELUM";
                        });
                        _searchSales();
                      },
                      items: ["", "SUDAH", "BELUM"].map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipe Penjualan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: _searchByTipePenjualanController.text,
                      onChanged: (value) {
                        setState(() {
                          _searchByTipePenjualanController.text =
                              value ?? "KREDIT";
                        });
                        _searchSales();
                      },
                      items: ["", "KREDIT", "CASH"].map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
            Expanded(
              child: FutureBuilder<List<SalesWithSaleItems>>(
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
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(1.5),
                          5: FlexColumnWidth(2),
                        },
                        children: [
                          // Header row
                          const TableRow(
                            decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Nama Penjualan",
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
                                  "Tanggal Penjualan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Tenggat Waktu",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Status Pembayaran",
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
                            final sale = item.sale;
                            return TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    sale?.namaPenjualan.toUpperCase() ?? "-",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    sale?.namaInstansi.toUpperCase() ?? "-",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    sale?.tanggalPenjualan.toString().split(
                                          " ",
                                        )[0] ??
                                        "-",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    sale?.tenggatWaktu.toString().split(
                                          " ",
                                        )[0] ??
                                        "-",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    sale?.sudahDibayar == true
                                        ? "Sudah"
                                        : "Belum",
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
                                                    SalesDetailPage(
                                                      item.sale!.id,
                                                    ),
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
                                        onPressed: () {
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
            ),
          ],
        ),
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
        _searchByTanggalPenjualanController.text = "$start/$end";
        _searchSales();
      });
    } else {
      setState(() {
        _searchByTanggalPenjualanController.clear();
        _searchSales();
      });
    }
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

  Future openDeleteConfirmationDialog(SalesWithSaleItems item) => showDialog(
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
              _deleteSale(item);
            },
            child: Text("Hapus"),
          ),
        ],
      );
    },
  );

  Future openTambahSalesDialog() =>
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Tambah Penjualan Baru"),
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
                                _sudahDibayarController.text = value ?? "KREDIT";
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Status penjualan tidak boleh kosong!';
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            if (value == null ||
                                                value.isEmpty) {
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
        for (var field in _identifierControllers) {
          field['unit']?.clear();
          field['multiplier']?.clear();
        }
        _identifierControllers.clear();
        _addNewIdentifierField();

        _namaPenjualanController.clear();
        _namaInstansiController.clear();
        _tanggalPenjualanController.clear();
        _tenggatPenjualanController.clear();
        _sudahDibayarController.text = "BELUM";
        _tipePenjualanController.text = "KREDIT";
      });
}
