import 'package:flutter/material.dart';
import 'package:project_toko/Item/model/item_with_unit_conversions.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:project_toko/database/database_instance.dart' as globals;
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});
  @override
  State<StatefulWidget> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Future<List<ItemWithUnitConversions>>? _itemsFuture;
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  final _namaFormKey = GlobalKey<FormState>();
  final _stokFormKey = GlobalKey<FormState>();
  final _hargaFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    setState(() {
      _itemsFuture = globals.database.itemsDao.getAllItemsWithUnitConversions();
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

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Tambah Item"), centerTitle: true),
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
                        setState(() {}); // untuk trigger FutureBuilder
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<ItemWithUnitConversions>>(
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
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            5, // misal 3 kolom per baris, sesuaikan sendiri
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2, // lebar:tinggi item grid
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Nama Item: ${item.item?.namaItem}",
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Harga Item: ${item.item?.hargaItem}",
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Stok: ${item.item?.stokUnitTerkecil}",
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Unit: ${item.item?.unitTerkecil}",
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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

  Future openTambahItemDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Tambah Item Baru"),
      content: Column(
        children: [
          Form(
            key: _namaFormKey,
            child: TextFormField(
              decoration: InputDecoration(label: Text("Nama Item")),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Nama item tidak boleh kosong!';
                }
                return null;
              },
            ),
          ),
          Form(
            key: _stokFormKey,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(label: Text("Stok")),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Stok tidak boleh kosong!';
                }
                return null;
              },
            ),
          ),
          Form(
            key: _hargaFormKey,
            child: TextFormField(
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
              decoration: InputDecoration(label: Text("Harga")),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Harga tidak boleh kosong!';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    ),
  );
}
