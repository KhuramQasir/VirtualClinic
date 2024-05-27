import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';
import 'package:video_player/video_player.dart';

class ApiService {
  Future<List<dynamic>> getPatientVideoCallResponse(int patientHistoryId) async {
    final response = await http.get(Uri.parse('$apiUrl/get_patient_video_call_response/$patientHistoryId'));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData[0]['data']; // Adjusted to access the 'data' field directly
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class PatientVideoResponseScreen extends StatefulWidget {
  const PatientVideoResponseScreen({Key? key}) : super(key: key);

  @override
  _PatientVideoResponseScreenState createState() => _PatientVideoResponseScreenState();
}

class _PatientVideoResponseScreenState extends State<PatientVideoResponseScreen> {
  late Future<List<dynamic>> futureResponses;

  @override
  void initState() {
    super.initState();
    futureResponses = ApiService().getPatientVideoCallResponse(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Video Responses'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureResponses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final response = snapshot.data![index];
                return VideoResponseTile(
                  diagnostic: response['diagnostic'],
                  question: response['question'],
                  videoUrl: response['response_video_url'],
                );
              },
            );
          }
        },
      ),
    );
  }
}
class VideoResponseTile extends StatefulWidget {
  final String diagnostic;
  final String question;
  final String videoUrl;

  const VideoResponseTile({
    Key? key,
    required this.diagnostic,
    required this.question,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoResponseTileState createState() => _VideoResponseTileState();
}

class _VideoResponseTileState extends State<VideoResponseTile> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    String formattedUrl = '$apiUrl/${widget.videoUrl.replaceAll('\\', '/')}'; // Combine base URL and path
    print('Video URL: $formattedUrl'); // Print the video URL to the console
    _initializeVideoPlayer(formattedUrl);
  }

  Future<void> _initializeVideoPlayer(String videoUrl) async {
    try {
      _controller = VideoPlayerController.network(videoUrl);
      _initializeVideoPlayerFuture = _controller.initialize();
      await _initializeVideoPlayerFuture;
      if (!_controller.value.isInitialized) {
        throw Exception('Failed to initialize video player');
      }
    } catch (error) {
      print('Error initializing video player: $error');
      // Handle specific error cases if needed
    } finally {
      if (!mounted) return; // Check if widget is still mounted
      setState(() {}); // Trigger a rebuild to update the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading video: ${snapshot.error}'));
                    } else if (!_controller.value.isInitialized) {
                      return Center(child: Text('Failed to load video'));
                    } else {
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      );
                    }
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100),
                     Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10), // Adjust the value to change the curve radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 2), // Adjust the shadow position if needed
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              widget.diagnostic,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red, // Optionally set text color
                              ),
                            ),
                          ),
                        )
                        ,
                      SizedBox(height: 70),
                      Text(widget.question),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_controller.value.isInitialized)
            VideoProgressIndicator(_controller, allowScrubbing: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
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
    _controller.dispose();
    super.dispose();
  }
}
