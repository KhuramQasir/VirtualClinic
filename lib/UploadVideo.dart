// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';


// class VideoSelectionScreen extends StatefulWidget {
//   @override
//   _VideoSelectionScreenState createState() => _VideoSelectionScreenState();
// }

// class _VideoSelectionScreenState extends State<VideoSelectionScreen> {
//   File? _video;

//   Future<void> _pickVideo() async {
//     final picker = ImagePicker();
//     final pickedVideo = await picker.getVideo(source: ImageSource.gallery);

//     setState(() {
//       _video = pickedVideo != null ? File(pickedVideo.path) : null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Video'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _video == null
//                 ? Text('No video selected.')
//                 : VideoPlayer(_video!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickVideo,
//               child: Text('Select Video'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class VideoPlayer extends StatelessWidget {
//   final File videoFile;

//   VideoPlayer(this.videoFile);

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9, // You can adjust this aspect ratio based on your video aspect ratio
//       child: Video.file(
//         videoFile,
//         controller: VideoPlayerController.file(videoFile),
//         // Add your desired options here, like looping, autoplay, etc.
//       ),
//     );
//   }
// }
