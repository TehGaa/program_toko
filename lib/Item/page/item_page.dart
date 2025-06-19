import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:project_toko/appbar.dart';
import 'package:project_toko/database/database.dart';

import 'package:project_toko/database/database_instance.dart' as globals;
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:project_toko/drawer.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});
  @override
  State<StatefulWidget> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Future<List<Item>>? _itemsFuture;
  final _searchController = TextEditingController();
  Timer? _debounce;
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final _unitController = TextEditingController(text: "pcs");

  final List<Map<String, TextEditingController>> _unitConversionControllers =
      [];

  @override
  void initState() {
    super.initState();
    _loadItems();
    _addNewUnitConversionField();
  }

  void _loadItems() {
    setState(() {
      _itemsFuture = globals.database.select(globals.database.items).get();
    });
  }

  void _searchItems(String keyword) {
    if (keyword.isEmpty) {
      _loadItems();
    } else {
      setState(() {
        _itemsFuture = globals.database.itemsDao.searchByName(keyword);
      });
    }
  }

  void _addNewUnitConversionField() {
    setState(() {
      _unitConversionControllers.add({
        'unit': TextEditingController(),
        'multiplier': TextEditingController(),
      });
    });
  }

  void _removeUnitConversionField(int index) {
    setState(() {
      _unitConversionControllers[index]['unit']!.dispose();
      _unitConversionControllers[index]['multiplier']!.dispose();
      _unitConversionControllers.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final nama = _namaController.text;
      final harga = _hargaController.text;
      final stok = _stokController.text;
      final unit = _unitController.text;

      // Ambil juga dari _unitConversionControllers
      final konversi = _unitConversionControllers.map((map) {
        return {
          "unit": map["unit"]!.text.toUpperCase(),
          "multiplier": int.parse(map['multiplier']!.text),
        };
      }).toList();

      String cleanedHarga = harga.replaceAll(RegExp(r'[^0-9]'), '');
      int hargaInt = int.parse(cleanedHarga);

      globals.database
          .into(globals.database.items)
          .insert(
            ItemsCompanion.insert(
              namaItem: nama.toUpperCase(),
              stokUnitTerkecil: int.parse(stok),
              unitTerkecil: unit.toUpperCase(),
              hargaItem: hargaInt,
              konversi: jsonEncode(konversi),
            ),
            mode: drift.InsertMode.insertOrIgnore,
          );

      Navigator.pop(context); // tutup dialog
      _loadItems();
      _searchController.clear();
    }
  }

  void _updateForm(Item item) {
    if (_formKey.currentState!.validate()) {
      final nama = _namaController.text;
      final harga = _hargaController.text;
      final stok = _stokController.text;
      final unit = _unitController.text;

      String cleanedHarga = harga.replaceAll(RegExp(r'[^0-9]'), '');
      int hargaInt = int.parse(cleanedHarga);

      // Ambil juga dari _unitConversionControllers
      final konversi = _unitConversionControllers.map((map) {
        return {
          "unit": map["unit"]!.text.toUpperCase(),
          "multiplier": int.parse(map['multiplier']!.text),
        };
      }).toList();

      final updatedItem = ItemsCompanion.insert(
        id: drift.Value(item.id),
        namaItem: nama.toUpperCase(),
        hargaItem: hargaInt,
        stokUnitTerkecil: int.parse(stok),
        unitTerkecil: unit.toUpperCase(),
        konversi: jsonEncode(konversi),
        updatedAt: drift.Value(DateTime.now())
      );

      globals.database.update(globals.database.items).replace(updatedItem);

      Navigator.pop(context); // tutup dialog
      _loadItems();
      _searchController.clear();
    }
  }

  void _deleteItem(Item item) {
    globals.database.delete(globals.database.items).delete(item);
    Navigator.pop(context);
    _loadItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    for (var field in _unitConversionControllers) {
      field['unit']?.dispose();
      field['multiplier']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Halaman Tambah Item"),
      drawer: ProjectTokoDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton(
                  child: Text("Tambah Item Baru"),
                  onPressed: () {
                    openTambahItemDialog();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari nama item...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();

                      _debounce = Timer(const Duration(milliseconds: 700), () {
                        _searchItems(value);
                        setState(() {});
                      });
                    },
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
            Expanded(
              child: FutureBuilder<List<Item>>(
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
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(3),
                          5: FlexColumnWidth(2),
                        },
                        children: [
                          // Header Row (if not already included)
                          const TableRow(
                            decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "NAMA ITEM",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "HARGA ITEM",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "STOK",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "UNIT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "KONVERSI UNIT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "OPERASI",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Dynamic rows for each item
                          ...items.map((item) {
                            final List<Map<String, dynamic>> konversi =
                                List<Map<String, dynamic>>.from(
                                  jsonDecode(item.konversi),
                                );

                            return TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    item.namaItem.toUpperCase(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    formatCurrency.format(item.hargaItem),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    item.stokUnitTerkecil.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    item.unitTerkecil,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: konversi.map((konv) {
                                      return Text(
                                        "- ${konv['unit']} : ${konv['multiplier']} ${item.unitTerkecil}",
                                        style: TextStyle(fontSize: 17),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            openUpdateItemDialog(item);
                                          },
                                          child: Text('Ubah'),
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

  Future openUpdateItemDialog(Item? item) {
    _namaController.text = item?.namaItem ?? "";
    _hargaController.text = formatCurrency.format(item?.hargaItem) ?? "";
    _stokController.text = item?.stokUnitTerkecil.toString() ?? "";
    _unitController.text = item?.unitTerkecil ?? "pcs";
    _unitConversionControllers.clear();
    final List<Map<String, dynamic>> konversiList =
        List<Map<String, dynamic>>.from(jsonDecode(item!.konversi));
    if (konversiList.isEmpty) {
      _addNewUnitConversionField();
    } else {
      for (Map<String, dynamic> konversiItem in konversiList) {
        setState(() {
          _unitConversionControllers.add({
            "unit": TextEditingController(text: konversiItem["unit"]),
            "multiplier": TextEditingController(
              text: konversiItem["multiplier"].toString(),
            ),
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
              title: Text("Update Item"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _formKey,

                      child: Column(
                        children: [
                          TextFormField(
                            controller: _namaController,
                            decoration: InputDecoration(
                              label: Text("Nama Item"),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama item tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _hargaController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(
                                leadingSymbol: 'Rp ',
                                useSymbolPadding: true,
                                thousandSeparator: ThousandSeparator.Period,
                                mantissaLength: 0,
                              ),
                            ],
                            decoration: InputDecoration(
                              label: Text("Harga Item"),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Harga tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _stokController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(label: Text("Stok")),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Stok tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _unitController,
                            decoration: InputDecoration(
                              label: Text("Unit Item"),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Unit item tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Konversi Unit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 10),
                    Column(
                      children: List.generate(
                        _unitConversionControllers.length,
                        (index) {
                          final unitController =
                              _unitConversionControllers[index]['unit']!;
                          final multiplierController =
                              _unitConversionControllers[index]['multiplier']!;

                          return Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: unitController,
                                  decoration: InputDecoration(
                                    labelText: 'Nama Unit',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nama unit tidak boleh kosong!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  controller: multiplierController,
                                  decoration: InputDecoration(
                                    labelText: 'multiplikasi',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Multiplikasi tidak boleh kosong!';
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
                                  () => _removeUnitConversionField(index),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text('Tambah Unit'),
                          onPressed: () {
                            setState(() {
                              _unitConversionControllers.add({
                                'unit': TextEditingController(),
                                'multiplier': TextEditingController(),
                              });
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: Text('Ubah'),
                              onPressed: () {
                                _updateForm(item!);
                              },
                            ),
                          ],
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
    ).then((_) {
      for (var field in _unitConversionControllers) {
        field['unit']?.clear();
        field['multiplier']?.clear();
      }
      _unitConversionControllers.clear();
      _addNewUnitConversionField();

      _namaController.clear();
      _hargaController.clear();
      _stokController.clear();
      _unitController.clear();
      _unitController.text = "pcs";
    });
  }

  Future openDeleteConfirmationDialog(Item item) => showDialog(
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
              _deleteItem(item);
            },
            child: Text("Hapus"),
          ),
        ],
      );
    },
  );

  Future openTambahItemDialog() =>
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Tambah Item Baru"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formKey,

                        child: Column(
                          children: [
                            TextFormField(
                              controller: _namaController,
                              decoration: InputDecoration(
                                label: Text("Nama Item"),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama item tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _hargaController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyInputFormatter(
                                  leadingSymbol: 'Rp ',
                                  useSymbolPadding: true,
                                  thousandSeparator: ThousandSeparator.Period,
                                  mantissaLength: 0,
                                ),
                              ],
                              decoration: InputDecoration(
                                label: Text("Harga Item"),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Harga tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _stokController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(label: Text("Stok")),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Stok tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _unitController,
                              decoration: InputDecoration(
                                label: Text("Unit Item"),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Unit item tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Konversi Unit",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            SizedBox(height: 10),
                            Column(
                              children: List.generate(
                                _unitConversionControllers.length,
                                (index) {
                                  final unitController =
                                      _unitConversionControllers[index]['unit']!;
                                  final multiplierController =
                                      _unitConversionControllers[index]['multiplier']!;

                                  return Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: unitController,
                                          decoration: InputDecoration(
                                            labelText: 'Nama Unit',
                                          ),
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Nama unit tidak boleh kosong!';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: TextFormField(
                                          controller: multiplierController,
                                          decoration: InputDecoration(
                                            labelText: 'multiplikasi',
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Multiplikasi tidak boleh kosong!';
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
                                          () =>
                                              _removeUnitConversionField(index),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  icon: Icon(Icons.add),
                                  label: Text('Tambah Unit'),
                                  onPressed: () {
                                    setState(() {
                                      _unitConversionControllers.add({
                                        'unit': TextEditingController(),
                                        'multiplier': TextEditingController(),
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
        for (var field in _unitConversionControllers) {
          field['unit']?.clear();
          field['multiplier']?.clear();
        }
        _unitConversionControllers.clear();
        _addNewUnitConversionField();

        _namaController.clear();
        _hargaController.clear();
        _stokController.clear();
        _unitController.clear();
        _unitController.text = "pcs";
      });
}
