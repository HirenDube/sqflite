import 'package:flutter/material.dart';

import 'main.dart';

class AnimatedWidgetPractice extends StatefulWidget {
  const AnimatedWidgetPractice({Key? key}) : super(key: key);

  @override
  State<AnimatedWidgetPractice> createState() => _AnimatedWidgetPracticeState();
}

class _AnimatedWidgetPracticeState extends State<AnimatedWidgetPractice>
    with SingleTickerProviderStateMixin {
  bool start = false;

  AnimationController? sizeControl;
  Animation<double>? inputSize;
  Animation<Color?>? inputColor;
  CurvedAnimation? curvy;


  @override
  void initState() {
    // TODO: implement initState
    sizeControl =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    curvy =CurvedAnimation(parent: sizeControl!, curve: Curves.elasticInOut);
    inputSize = Tween<double>(begin: 15, end: 150).animate(curvy!);
    inputColor = ColorTween(begin: Colors.red, end: Colors.lightBlue)
        .animate(curvy!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: 'AnimatedWidgetPractice', bgColor: Colors.deepPurpleAccent),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _AnimatedWidget(animateSize: inputSize, animateColor: inputColor),
          ElevatedButton(onPressed: (){
            start = !start;
            start ?
            sizeControl!.repeat(reverse: true) : sizeControl!.stop();
            setState(() {

            });
          }, child: Text(start ?  "Stop" : "Start"))
        ],
      ),
    );
  }
}

class _AnimatedWidget extends AnimatedWidget {
  Animation<double>? animateSize;
  Animation<Color?>? animateColor;

  String displayTxt = "Jai Shree Krishna";

  _AnimatedWidget({this.animateSize, this.animateColor})
      : super(
          listenable: animateSize!,
        );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        displayTxt,
        style:
            TextStyle(fontSize: animateSize!.value, color: animateColor!.value),
      ),
    );
  }
}
