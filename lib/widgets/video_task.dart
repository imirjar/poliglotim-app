import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoTask extends StatefulWidget {
  final String data;

  VideoTask({required this.data});

  @override
  _VideoTaskState createState() => _VideoTaskState();
}

class _VideoTaskState extends State<VideoTask> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.data);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Обучающее видео:", style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Chewie(controller: _chewieController),
              )
            : CircularProgressIndicator(),
      ],
    );
  }
}