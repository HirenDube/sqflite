import 'package:flutter/material.dart';

class BuildFuture extends StatefulWidget {
  const BuildFuture({Key? key}) : super(key: key);

  @override
  State<BuildFuture> createState() => _BuildFutureState();
}

class _BuildFutureState extends State<BuildFuture> {
  int waitTime = 5;

  List source = [  ];

  Future<String> urlProvider() async {
    await Future.delayed(Duration(seconds: 5));
    waitTime--;
    return "https://i.gifer.com/origin/df/df164e227cd65f612b9ae314ed203acc_w200.webp";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Futuer Builder"),
      ),
      body: Center(
        child: ListView(
          children: [
            Text(
              "A magic is about to happen, please be patient and watch",
              style: TextStyle(fontSize: 20),
            ),
            FutureBuilder(
                future: urlProvider(),
                builder: (BuildContext contex, snapSot) {
                  if (snapSot.hasData) {
                    return Image.network(snapSot.data.toString());
                  } else {
                    return Column(
                      children: [
                        // for(int i = 0 ; i<=4 ; i++,waitTime-- )
                        //   if(waitTime>=0)
                            RichText(
                              text: TextSpan(
                                  text: "Wait for ",
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: "${waitTime} ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red)),
                                    TextSpan(
                                        text: "seconds.",
                                        style: TextStyle(color: Colors.black))
                                  ])),
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
