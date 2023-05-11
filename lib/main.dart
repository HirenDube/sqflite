import "package:crud_pract_2nd_app/Extended%20Image.dart";
import "package:crud_pract_2nd_app/Image%20Picker.dart";
import "package:crud_pract_2nd_app/VideoPlayer.dart";
import "package:flutter/material.dart";

void main() {

  String imgEditSaveLink = "https://github.com/Virendratrivedi123/ImageEditor.git";
  ThemeData darkMode = ThemeData();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VideoPlayer2(),
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
