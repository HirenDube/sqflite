import "dart:math";

import "package:flutter/material.dart";

class ImpliAnimaBuilder extends StatefulWidget {
  const ImpliAnimaBuilder({Key? key}) : super(key: key);

  @override
  State<ImpliAnimaBuilder> createState() => _ImpliAnimaBuilderState();
}

class _ImpliAnimaBuilderState extends State<ImpliAnimaBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _iAmTheBossHere;
  late Animation _iAmEmployeeHere;
  String image = "assets/images/pubg.png";

  double rotationStarts = 0;
  double rotationEnds = 2 * pi;

  Gradient gradientColor =
      LinearGradient(colors: [Colors.red, Colors.green, Colors.yellow]);

  bool startTicking = true;

  @override
  void initState() {
    // TODO: implement initState
    _iAmTheBossHere =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _iAmEmployeeHere = Tween(begin: rotationStarts, end: rotationEnds)
        .animate(_iAmTheBossHere);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Animated Builder"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Divider(),
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, gradient: gradientColor),
              child: AnimatedBuilder(
                animation: _iAmEmployeeHere,
                child: Image.asset(image),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _iAmEmployeeHere.value,
                    child: child,
                  );
                },
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () async {
                  await _iAmTheBossHere.forward();
                  _iAmTheBossHere.reverse();
                },
                child: Text(
                  "Play/Pause",
                  style: TextStyle(color: Colors.black),
                )),
            Divider(),
          ],
        ),
      ),
    );
  }
}
