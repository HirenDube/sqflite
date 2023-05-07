
import 'package:crud_pract_2nd_app/main.dart';
import 'package:flutter/material.dart';

class FVideoPlayer extends StatefulWidget {
  const FVideoPlayer({Key? key}) : super(key: key);

  @override
  State<FVideoPlayer> createState() => _FVideoPlayerState();
}

class _FVideoPlayerState extends State<FVideoPlayer> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Video Palyer in Flutter", bgColor: Colors.redAccent),
      body: Container(
        child: Text("//Video Player here"),
      ),
    );
  }
}
