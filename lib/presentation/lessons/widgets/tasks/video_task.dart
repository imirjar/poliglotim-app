// lib/widgets/video_task.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTask extends StatefulWidget {
  final String data; // URL видео

  const VideoTask({super.key, required this.data});

  @override
  VideoTaskState createState() => VideoTaskState();
}

class VideoTaskState extends State<VideoTask> {
  late VideoPlayerController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.data)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }).catchError((error) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = "Ошибка загрузки видео: ${error.toString()}";
            });
          }
        });

      // Обработка ошибок воспроизведения
      _controller.addListener(() {
        if (_controller.value.hasError) {
          if (mounted) {
            setState(() {
              _hasError = true;
              _isLoading = false;
              _errorMessage = "Ошибка воспроизведения видео: ${_controller.value.errorDescription}";
            });
          }
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _errorMessage = "Ошибка инициализации видео: ${e.toString()}";
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Освобождаем ресурсы
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            Text(
              _errorMessage,
              style: const TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Обучающее видео:", style: TextStyle(fontSize: 20)),
        // backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      // backgroundColor: Colors.deepPurpleAccent[100],
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            // width: 848,
            height: 480,
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.yellow, width: 4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: FittedBox(
                fit: BoxFit.cover, // Set BoxFit to cover the entire container
                child: SizedBox(
                  // width: _controller.value.size.width,
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              )
            ),
          ),
          IconButton(
            icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
          ),
        ]
      )
    );
  }
}