import 'package:flutter/material.dart';
import 'package:project_toko/main.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<StatefulWidget> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
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
              mainAxisAlignment:
                  MainAxisAlignment.center, // 👈 Horizontally center the button
              children: [
                ElevatedButton(
                  child: Text("Tambah Item Baru"),
                  onPressed: () {
                    openTambahItemDialog();
                  },
                ),
              ],
            ),
            // Add more widgets below if needed
          ],
        ),
      ),
    );
  }

  Future openTambahItemDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Tambah Item Baru"),
      content: TextField(decoration: InputDecoration(label: Text("Nama Item"))),
    ),
  );
}
