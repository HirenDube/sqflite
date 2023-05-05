import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitlyAnimatedContainer extends StatefulWidget {
  const ImplicitlyAnimatedContainer({Key? key}) : super(key: key);

  @override
  State<ImplicitlyAnimatedContainer> createState() =>
      _ImplicitlyAnimatedContainerState();
}

class _ImplicitlyAnimatedContainerState
    extends State<ImplicitlyAnimatedContainer> {
  Gradient gradientColor =
      LinearGradient(colors: [Colors.red, Colors.green, Colors.yellow]);

  double containerHeight = 400;
  double containerWidth = 400;

  double radious = 10;

  List<Curve> containerAnimations = [
    Curves.bounceIn,
    Curves.bounceInOut,
    Curves.bounceOut,
    Curves.decelerate,
    Curves.elasticIn,
    Curves.elasticOut,
    Curves.elasticInOut,
    Curves.easeIn,
    Curves.easeInOutCubicEmphasized,
    Curves.easeInSine,
    Curves.easeInExpo,
    Curves.easeInOutExpo,
    Curves.easeInToLinear,
    Curves.fastLinearToSlowEaseIn,
  ];

  String imageUrl = "https://static.wikia.nocookie.net/kimetsu-no-yaiba/images/0/0e/Muzan_Kibutsuji_Full_Body_%28Anime%29.png/revision/latest?cb=20210731042132";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ImplicitlyAnimatedContainer"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            AnimatedContainer(
              height: containerHeight,
              width: containerWidth,
              child: Image.network(
                  imageUrl),
              curve: containerAnimations[
                  Random().nextInt(containerAnimations.length)],
              decoration: BoxDecoration(
                gradient: gradientColor,
                borderRadius: BorderRadius.circular(radious),
              ),
              duration: Duration(seconds: 2),
            ),
            Spacer(),

            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(fixedSize: Size(350, 40)),
                onPressed: () {
                  setState(() {
                    gradientColor = LinearGradient(colors: [
                      Color.fromRGBO(Random().nextInt(256),
                          Random().nextInt(256), Random().nextInt(256), 1),
                      Color.fromRGBO(Random().nextInt(256),
                          Random().nextInt(256), Random().nextInt(256), 1),
                      Color.fromRGBO(Random().nextInt(256),
                          Random().nextInt(256), Random().nextInt(256), 1),
                    ]);
                    containerHeight = Random().nextDouble() * 450 + 20;
                    containerWidth = Random().nextDouble() * 450 + 20;
                    radious = (Random().nextInt(50) + 20);
                  });
                },
                icon: Icon(Icons.change_circle_outlined),
                label: Text(
                  "Transform",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
