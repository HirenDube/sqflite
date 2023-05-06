import "package:flutter/material.dart";

import "Animated Widget.dart";

void main() {
  ThemeData darkMode = ThemeData();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedWidgetPractice(),
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