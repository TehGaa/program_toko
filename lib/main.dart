import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_toko/Item/page/item_page.dart';
import 'package:project_toko/Purchases/page/purchases_page.dart';
import 'package:project_toko/Sales/page/sales_page.dart';
import 'package:project_toko/appbar.dart';
import 'package:project_toko/database/database.dart';
import 'package:project_toko/drawer.dart';
import 'package:project_toko/database/database_instance.dart' as globals;
import 'package:drift/drift.dart' as drift;

void main() async {
  // globals.database.salesDao.insertSaleWithSaleItems(
  //   namaPenjualan: "testing2",
  //   namaInstansi: "testing",
  //   tanggalPenjualan: DateTime.now(),
  //   tenggatWaktu: DateTime.now().add(const Duration(days: 30)),
  //   identifiers: jsonEncode([{"field":"no.Po", "isi":"halo"}]),
  //   saleItems: [
  //     SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //           SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //     SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //     SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //     SaleItemsCompanion.insert(
  //       namaItem: "PULPEN",
  //       jumlah: 10,
  //       harga: 10000,
  //       unit: "lusin",
  //       unitTerkecil: "pcs",
  //       multiplier: 12,
  //       saleId: 0
  //     ),
  //   ],
  // );
  // print(await globals.database.select(globals.database.sales).get());

  // globals.database.into(globals.database.purchases).insert(PurchasesCompanion.insert(
  //   namaPembelian: "TESTING",
  //   namaInstansi: "TESTING",
  //   tipePembelian: drift.Value("KREDIT"),
  //   sudahDibayar: drift.Value(false),
  //   tanggalPembelian: drift.Value(DateTime.now())
  // ));

  // globals.database
  //     .into(globals.database.purchaseItems)
  //     .insert(
  //       PurchaseItemsCompanion.insert(
  //         namaItem: "PULPEN",
  //         jumlah: 10,
  //         harga: 10000,
  //         unit: "lusin",
  //         unitTerkecil: "pcs",
  //         multiplier: 12,
  //         purchaseId: 6,
  //       ),
  //     );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static var title = "Mandiri Jaya";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Mandiri Jaya'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: buildAppBar(context, "Mandiri Jaya"),
      drawer: ProjectTokoDrawer(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text("SELAMAT DATANG DI PROGRAM TOKO", style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),),
              Text("Pilih salah satu menu di bawah:", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SalesPage()),
                      );
                    },
                    child: Text(
                      "PENJUALAN",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PurchasesPage(),
                        ),
                      );
                    },
                    child: Text(
                      "PEMBELIAN",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ItemPage()),
                      );
                    },
                    child: Text(
                      "ITEM",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
