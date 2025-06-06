import 'package:flutter/material.dart';
import 'package:project_toko/Item/page/item_page.dart';

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
            title: const Text("Tambah Item"),
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ItemPage())
              );
            },
          )
        ],
      ),
    );
  }
}