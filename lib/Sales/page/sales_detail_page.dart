import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:project_toko/Sales/model/sales_with_sale_items.dart';
import 'package:project_toko/appbar.dart';
import 'package:project_toko/database/database.dart';
import 'package:project_toko/drawer.dart';
import 'package:intl/intl.dart';
import 'package:project_toko/database/database_instance.dart' as globals;

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

  final _namaPenjualanController = TextEditingController();
  final _namaInstansiController = TextEditingController();
  final _tanggalPenjualanController = TextEditingController();
  final _tenggatPenjualanController = TextEditingController();
  final _sudahDibayarController = TextEditingController(text: "BELUM");

  final _namaItemController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _hargaController = TextEditingController();
  final _unitTerkecilController = TextEditingController();
  final _unitController = TextEditingController();
  final _multiplierController = TextEditingController();

  final List<Map<String, TextEditingController>> _identifierControllers = [];

  @override
  void initState() {
    super.initState();
    _loadSales();
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
      final tanggalPenjualan = DateTime.parse(_tanggalPenjualanController.text);
      final tenggatWaktu = DateTime.parse(_tenggatPenjualanController.text);
      final sudahDibayar = _sudahDibayarController.text == "SUDAH"
          ? true
          : false;

      final identifiers = _identifierControllers.map((map) {
        return {"field": map["field"]!.text, "isi": map["isi"]!.text};
      }).toList();

      final jsonIdentifier = jsonEncode(identifiers);

      final updatedSale = SalesCompanion.insert(
        id: drift.Value(sale.sale!.id),
        namaPenjualan: namaPenjualan,
        namaInstansi: namaInstansi,
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
            onPressed: () {},
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

        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text(
                  "ITEM PENJUALAN",
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
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // openUpdateItemDialog(item);
                                        },
                                        child: Text(
                                          "Ubah",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          // openDeleteConfirmationDialog(item);
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
                        })
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
                _buildItemSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Future _openTambahSaleItemDialog(Sale sale){
    throw Error();
  }

  Future _openUpdateInfoSale(SalesWithSaleItems sale) {
    _namaPenjualanController.text = sale.sale?.namaPenjualan ?? "";
    _namaInstansiController.text = sale.sale?.namaInstansi ?? "";
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
}
