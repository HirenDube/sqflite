import 'package:crud_pract_2nd_app/main.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer2 extends StatefulWidget {
  const VideoPlayer2({Key? key}) : super(key: key);

  @override
  State<VideoPlayer2> createState() => _VideoPlayer2State();
}

class _VideoPlayer2State extends State<VideoPlayer2> {
  String url = "https://www.w3schools.com/html/mov_bbb.mp4 ";
  VideoPlayerController? controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = VideoPlayerController.network(url)
      ..initialize().then((value) {
        setState(() {
          controller!.play();
        });
      })
      ..setLooping(true)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Video Player", bgColor: Colors.pink),
      body: Column(
        children: [
          if (controller != null && controller!.value.isInitialized)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(controller!),
            )
          else
            CircularProgressIndicator(),
          Text("${controller!.value.position} / ${controller!.value.duration}"),
          VideoProgressIndicator(controller!,
              allowScrubbing: true,
              padding: EdgeInsets.all(10),
              colors: VideoProgressColors(
                playedColor: Colors.greenAccent,
              )),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [

              IconButton(
                onPressed: () {
                  setState(() {
                    controller!.value.isPlaying
                        ? controller!.pause()
                        : controller!.play();
                  });
                },
                icon: Icon(controller!.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow),
              ),

            ],
          )
        ],
      ),
    );
  }
}
