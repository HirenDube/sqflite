import "package:flutter/material.dart";

import "SQFlite.dart";

void main() {

  // String imgEditSaveLink = "https://github.com/Virendratrivedi123/ImageEditor.git";
  ThemeData darkMode = ThemeData();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SQFlite(),
    theme: darkMode,
  ));
}

AppBar buildAppBar({required String title, required Color bgColor,actions}) {
  return AppBar(
    title: Text(title),
    backgroundColor: bgColor,
    actions: actions,
  );
}
