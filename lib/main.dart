import "package:flutter/material.dart";

import "Wallpaper App.dart";

void main() {
  ThemeData darkMode = ThemeData();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyWallpaperApp(),
    theme: darkMode,
  ));
}




AppBar buildAppBar({
  required String title,
  required Color bgColor
}) {
  return AppBar(title:Text(title),
    backgroundColor:bgColor,);
}