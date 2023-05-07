import "package:crud_pract_2nd_app/VideoPlayer.dart";
import "package:flutter/material.dart";

import "Animated Widget.dart";

void main() {
  ThemeData darkMode = ThemeData();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FVideoPlayer(),
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