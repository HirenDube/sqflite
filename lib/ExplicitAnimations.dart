import 'package:flutter/material.dart';

import 'main.dart';

class LowLvlAnimation extends StatefulWidget {
  const LowLvlAnimation({Key? key}) : super(key: key);

  @override
  State<LowLvlAnimation> createState() => _LowLvlAnimationState();
}

class _LowLvlAnimationState extends State<LowLvlAnimation>
    with TickerProviderStateMixin {
  bool startAnimating = false;
  Animation<double>? size;
  Animation<Color?>? color;
  CurvedAnimation? curvedAnime;

  AnimationController? controllAnime;

  @override
  void initState() {
    // TODO: implement initState
    controllAnime =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    curvedAnime =
            CurvedAnimation(parent: controllAnime!, curve: Curves.easeInOutCirc)
              ..addListener(() {
                setState(() {});
              })
        ;
    size = Tween<double>(begin: 200, end: 400).animate(curvedAnime!);
    color = ColorTween(begin: Colors.amberAccent, end: Colors.deepPurpleAccent)
        .animate(curvedAnime!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(title: 'Low Level Animations', bgColor: Colors.amber),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size!.value,
                width: size!.value,
                decoration: BoxDecoration(
                  color: color!.value,
                  image: DecorationImage(
                      image: AssetImage("assets/images/naruto.png")),
                  shape: BoxShape.circle,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      startAnimating = !startAnimating;
                      startAnimating
                          ? controllAnime?.repeat(reverse: true)
                          : controllAnime!.stop();
                    });
                  },
                  child: Text(startAnimating ? "Pause" : "Play")),
            ],
          ),
        ),
      ),
    );
  }
}
