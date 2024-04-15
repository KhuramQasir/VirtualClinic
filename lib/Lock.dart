
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:mcqs/Camera.dart';
// import 'package:mcqs/main.dart';
// import 'package:path_provider/path_provider.dart';

// class LockScreen extends StatefulWidget {
//   const LockScreen({Key? key}) : super(key: key);

//   @override
//   State<LockScreen> createState() => _LockScreenState();
// }

// class _LockScreenState extends State<LockScreen> {
//   late CameraController controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(cameras[0], ResolutionPreset.max);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//   var pass = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: <Widget>[
//         Container(
//           height: MediaQuery.of(context).size.height * 0.4,
//           child: Text('Enter passowrd'),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (v) {
//                 setState(() {
//                   pass = v;
//                 });
//               },
//               decoration: InputDecoration(border: OutlineInputBorder()),
//             ),
//           ),
//         ),
//         Center(
//             child: ElevatedButton(
//           onPressed: (()async{
//             if (!controller.value.isInitialized && pass =="pass") {
//       final Directory extDir = await getApplicationDocumentsDirectory();
//      final String dirPath='${extDir.path}/Pictures/flutter_test';
//       await Directory(dirPath).create(recursive:true);
//       final String filePath ='$dirPath/k.jpg';
//       try{
//         final image = await controller.takePicture();
//         await controller.takePicture();

//       }
//       on CameraException catch(e){
//         print(e);
//         return null;
//       }
//       Navigator.push(context, MaterialPageRoute(builder: (_)=>Camera(image:File(filePath))));
//     }
   
//           }  
//           ),
//           child: Text('unlock'),
//         )
//         )
//       ],
//     ));
//   }
// }
// // var cameras;
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   cameras = await availableCameras();

// // }