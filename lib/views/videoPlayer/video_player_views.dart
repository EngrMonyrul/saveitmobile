import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  const VideoPlayerScreen({super.key, required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool playingVideo = false;
  String currentTime = '';
  String totalTime = '';
  Timer? timer;

  void setVideoPlayerController() {
    _controller = VideoPlayerController.file(
      File(widget.videoPath),
    )..initialize().then(
        (_) {
          setState(
            () {
              _controller.play();
            },
          );
        },
      );

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        totalTime = formatDuration(_controller.value.duration);
        currentTime = formatDuration(_controller.value.position);
      });
    });

    setState(() {
      playingVideo = true;
    });
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String formattedTime = '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';

    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    setVideoPlayerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: playingVideo
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(currentTime, style: GoogleFonts.libreBaskerville(color: Colors.white)))),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                          icon: _controller.value.isPlaying
                              ? Icon(CupertinoIcons.play_circle, color: Colors.white, size: 40)
                              : Icon(CupertinoIcons.pause_circle, color: Colors.white, size: 40),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(totalTime, style: GoogleFonts.libreBaskerville(color: Colors.white)))),
                    ],
                  ),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            )
          : null,
      body: playingVideo
          ? Center(
              child: Stack(
                children: [
                  (widget.videoPath.contains('.mp4'))
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : SizedBox(
                          child: VideoPlayer(_controller),
                        ),
                  if (widget.videoPath.contains('.mp3'))
                    RippleWave(
                      color: Colors.grey,
                      child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child: Icon(CupertinoIcons.music_note_2, size: 50, color: Colors.white)),
                    )
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    timer!.cancel();
  }
}
