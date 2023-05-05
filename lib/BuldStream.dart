import "package:flutter/material.dart";

class BuildStream extends StatefulWidget {
  const BuildStream({Key? key}) : super(key: key);

  @override
  State<BuildStream> createState() => _BuildStreamState();
}

class _BuildStreamState extends State<BuildStream> {

  Stream<int> repeater = Stream.periodic(Duration(seconds: 1), (i) => i);
  bool clockStarted = false;
  bool clockOpened1stTime = true;
  TimeOfDay stoppedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real - Time Clock"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: repeater,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (clockStarted && snapshot.hasData) {
                TimeOfDay currentTime = TimeOfDay.now();
                stoppedTime = currentTime;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 6,
                      child: Text(
                        "${currentTime.hourOfPeriod} : ${currentTime.minute}  ${currentTime.period}" ,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Flexible(
                      flex: 6,
                      child: ElevatedButton(
                          onPressed: () {
                            clockStarted = !clockStarted;
                          },
                          child: Text("STOP")),
                    )
                  ],
                );
              } else {
                // DateTime currentTime = (DateTime.now());
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 6,
                      child: Card(
                        child: Text(
                          clockOpened1stTime
                              ? "00 : 00 : 00"
                              : "${stoppedTime.hour} : ${stoppedTime.minute}  ${stoppedTime.toString()}",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Flexible(
                      flex: 6,
                      child: ElevatedButton(
                          onPressed: () {
                            clockStarted = !clockStarted;
                            clockOpened1stTime = false;
                          },
                          child: Text("START")),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }
}
