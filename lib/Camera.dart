import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(Camera());
}

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late String _capturedImagePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    // Get the front camera
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;

    try {
      final image = await _controller.takePicture();
      _capturedImagePath = image.path;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImageScreen(imagePath: _capturedImagePath),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Secret Camera')),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class DisplayImageScreen extends StatelessWidget {
  final String imagePath;

  const DisplayImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Captured Image')),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}


// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// void main() {
//   runApp(Camera());
// }

// class Camera extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CameraScreen(),
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   late String _capturedImagePath;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//     _controller = CameraController(firstCamera, ResolutionPreset.medium);
//     _initializeControllerFuture = _controller.initialize();
//     await _initializeControllerFuture;

//     try {
//       final image = await _controller.takePicture();
//       _capturedImagePath = image.path;
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => DisplayImageScreen(imagePath: _capturedImagePath),
//         ),
//       );
//     } catch (e) {
//       print('Error taking picture: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Secret Camera')),
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// class DisplayImageScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayImageScreen({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Captured Image')),
//       body: Center(
//         child: Image.file(File(imagePath)),
//       ),
//     );
//   }
// }


//-------------------------------------------------------------------
// import 'dart:io';

// import 'package:flutter/material.dart';

// class Camera extends StatefulWidget {
//   final File image;

//   const Camera({Key? key, required this.image}) : super(key: key);

//   @override
//   State<Camera> createState() => _CameraState();
// }

// class _CameraState extends State<Camera> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Home'),
//         ),
//         body: Column(children: <Widget>[
//           Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25)),
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.file(
//                   widget.image,
//                   height: 200,
//                   width: 200,
//                 ),
//               ))
//         ]));
//   }
// }
