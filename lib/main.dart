import "package:crud_pract_2nd_app/LottieAnimations.dart";
import "package:flutter/material.dart";

void main() {
  ThemeData darkMode = ThemeData();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Lotty(),
    theme: darkMode,
  ));
}

AppBar buildAppBar({required String title, required Color bgColor}) {
  return AppBar(
    title: Text(title),
    backgroundColor: bgColor,
  );
}
