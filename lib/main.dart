import "package:flutter/material.dart";

import "Wallpaper App.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyWallpaperApp(),
  ));
}

AppBar buildAppBar(
    {required String title, required Color bgColor, List<Widget>? actions}) {
  return AppBar(
    title: Text(title),
    backgroundColor: bgColor,
    actions: actions,
  );
}
