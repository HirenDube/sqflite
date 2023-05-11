import 'package:crud_pract_2nd_app/main.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer2 extends StatefulWidget {
  const VideoPlayer2({Key? key}) : super(key: key);

  @override
  State<VideoPlayer2> createState() => _VideoPlayer2State();
}

class _VideoPlayer2State extends State<VideoPlayer2> {
  VideoPlayerController? controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = VideoPlayerController.network(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
      ..initialize().then((value) {
        setState(() {});
      })
      ..setLooping(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Video Player", bgColor: Colors.pink),
      body: Column(
        children: [
          if(controller != null && controller!.value.isInitialized)
            SizedBox(
              height: 500,
              width: 500,
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Expanded(child: VideoPlayer(controller!)),
              ),
            )
          else
            CircularProgressIndicator()
        ],
      ),
    );
  }
}
