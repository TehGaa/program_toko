import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String s) {
  return AppBar(
    title: Text(s),
    elevation: 2.2,
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Color.fromRGBO(38, 38, 38, 1)),
    shadowColor: Color.fromRGBO(38, 38, 38, 1),
  );
}
