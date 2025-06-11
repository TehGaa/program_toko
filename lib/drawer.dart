import 'package:flutter/material.dart';
import 'package:project_toko/Item/page/item_page.dart';
import 'package:project_toko/Sales/page/sales_page.dart';
import 'package:project_toko/Purchases/page/purchases_page.dart';
import 'package:project_toko/main.dart';

class ProjectTokoDrawer extends StatefulWidget {
  const ProjectTokoDrawer({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectTokoDrawerState();
}

class _ProjectTokoDrawerState extends State<ProjectTokoDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: "Mandiri Jaya"),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Penjualan"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SalesPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Pembelian"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PurchasesPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Item"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ItemPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
