import "package:crud_pract_2nd_app/Animated%20Builder.dart";
import "package:crud_pract_2nd_app/Animated%20Container.dart";
import "package:crud_pract_2nd_app/BuldStream.dart";
import "package:crud_pract_2nd_app/HeroAnimations.dart";
import "package:crud_pract_2nd_app/WhatsappHeroAnimation.dart";
import "package:flutter/material.dart";

void main() {
  ThemeData darkMode = ThemeData();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ImpliAnimaBuilder(),
    theme: darkMode,
  ));
}
