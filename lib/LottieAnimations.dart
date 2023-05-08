import 'package:crud_pract_2nd_app/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Lotty extends StatefulWidget {
  const Lotty({Key? key}) : super(key: key);

  @override
  State<Lotty> createState() => _LottyState();
}

class _LottyState extends State<Lotty> with SingleTickerProviderStateMixin {
  AnimationController? lottyController;
  bool paused = true;

  @override
  void initState() {
    // TODO: implement initState
    lottyController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: "Lottie Animations",
        bgColor: Colors.deepOrange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.asset("assets/lotties/burger.json",
              height: 200,
              width: 200,
              fit: BoxFit.contain,
              controller: lottyController),
          Lottie.network(
              "https://assets3.lottiefiles.com/packages/lf20_3amATTeKJ3.json",
              height: 200,
              width: 200,
              fit: BoxFit.contain,
              controller: lottyController),
          ButtonBar(
            alignment: MainAxisAlignment.center ,
            children: [
              IconButton(
                  onPressed: () {
                    lottyController!.reverse();
                  },
                  icon: Icon(Icons.skip_previous)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      paused = !paused;
                      paused
                          ? lottyController!.stop()
                          : lottyController!.repeat(reverse: true);
                    });
                  },
                  icon: Icon(paused ? Icons.play_arrow : Icons.pause)),
              IconButton(
                  onPressed: () {
                    lottyController!.forward();
                  },
                  icon: Icon(Icons.skip_next)),
            ],
          ),
        ],
      ),
    );
  }
}
