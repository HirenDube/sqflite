import "package:crud_pract_2nd_app/Image%20Picker.dart";
import "package:flutter/material.dart";

void main() {
  ThemeData darkMode = ThemeData();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PickTheImage(),
    theme: darkMode,
  ));
}

AppBar buildAppBar({required String title, required Color bgColor}) {
  return AppBar(
    title: Text(title),
    backgroundColor: bgColor,
  );
}
