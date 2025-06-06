import 'package:flutter/material.dart';
import 'package:project_toko/database.dart';
import 'package:flutter/services.dart';

import 'package:project_toko/database_instance.dart' as globals;
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});
  @override
  State<StatefulWidget> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Future<List<Item>>? _itemsFuture;

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
      _itemsFuture = globals.database.select(globals.database.items).get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Tambah Item"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("Tambah Item Baru"),
                  onPressed: () {
                    openTambahItemDialog();
                  },
                ),
              ],
            ),
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
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(title: Text(item.nama));
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
                  leadingSymbol:
                      'Rp ',
                  useSymbolPadding: true,
                  thousandSeparator:
                      ThousandSeparator.Period, 
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
