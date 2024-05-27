import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late Future<List<String>> futureVideos;

  @override
  void initState() {
    super.initState();
    futureVideos = _fetchVideosFromApi();
  }

  Future<List<String>> _fetchVideosFromApi() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.37:5000/patient_response_video/patientid-12_2024-05-19_video0/video.mp4'));

      if (response.statusCode == 200) {
        return [response.body]; // Assuming only one video URL is returned
      } else {
        throw Exception('Failed to load videos: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Video Player'),
        ),
        body: FutureBuilder<List<String>>(
          future: futureVideos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No videos available'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final videoUrl = snapshot.data![index];
                  return FutureBuilder(
                    future: _initializeVideoPlayer(videoUrl),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error loading video: ${snapshot.error}'));
                      } else {
                        return VideoTile(controller: snapshot.data as VideoPlayerController);
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<VideoPlayerController> _initializeVideoPlayer(String videoUrl) async {
    final controller = VideoPlayerController.network(videoUrl);
    await controller.initialize();
    return controller;
  }
}

class VideoTile extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoTile({Key? key, required this.controller}) : super(key: key);

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late Future<void> _disposeControllerFuture;

  @override
  void initState() {
    super.initState();
    _disposeControllerFuture = widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: VideoPlayer(widget.controller),
          ),
          VideoProgressIndicator(widget.controller, allowScrubbing: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _disposeControllerFuture.then((_) => widget.controller.dispose());
    super.dispose();
  }
}
