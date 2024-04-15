import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:mcqs/Home.dart';
import 'constants.dart';

class SessionWithResponse extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<SessionWithResponse> {
  late Future<List<QuestionData>> questionData;
  String? selectedOption;
  int currentIndex = 0;
  late CameraController _cameraController;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
    questionData = fetchQuestionData();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<List<QuestionData>> fetchQuestionData() async {
    final response = await http.get(Uri.parse('$apiUrl/SessionDetails'));

    if (response.statusCode == 200) {
      final List<dynamic> questionData = json.decode(response.body)[0];
      return questionData.map((e) => QuestionData.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load question');
    }
  }

  Future<void> _captureAndSave(String selectedOption) async {
    if (_cameraController.value.isInitialized) {
      XFile? file = await _cameraController.takePicture();
      String imagePath = file!.path;
      saveDataToDatabase(imagePath, selectedOption);
    }
  }

  Future<void> saveDataToDatabase(String imagePath, String selectedOption) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/add_session_record'),
        body: jsonEncode({
          'selected_option': selectedOption,
          'patient_response_image': imagePath,
          // Assuming you have session_details_id and patient_history_id available
          'session_details_id': 1, // Replace with actual session_details_id
          'patient_history_id': 1, // Replace with actual patient_history_id
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Data saved successfully
      } else {
        // Error handling
        print('Failed to save data: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Error handling
      print('Error saving data: $error');
    }
  }

  void navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Virtual Clinic"),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: FutureBuilder<List<QuestionData>>(
          future: questionData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  if (index == currentIndex) {
                    return buildQuestionContent(snapshot.data![index]);
                  } else {
                    return SizedBox.shrink();
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: navigateToHome,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle Search Icon press
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle Notifications Icon press
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle Settings Icon press
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              final data = await questionData;
              setState(() {
                currentIndex++;
                if (currentIndex >= data.length) {
                  // Show session end notification
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Session End"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                  currentIndex = 0;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildQuestionContent(QuestionData data) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 7),
        child: Column(
          children: <Widget>[
            const Text(
              "Look at this picture",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Image.network(data.imageUrl),
            SizedBox(height: 27),
            Text(
              data.questionText,
              style: TextStyle(fontSize: 16),
            ),
            ...List.generate(
              data.options.length,
              (index) => RadioListTile<String>(
                title: Text(data.options[index]),
                value: data.options[index],
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value!;
                    _captureAndSave(selectedOption!);
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final data = await questionData;
                setState(() {
                  currentIndex++;
                  if (currentIndex >= data.length) {
                    // Show session end notification
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Session End"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                    currentIndex = 0;
                  }
                });
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionData {
  final int id;
  final String imageUrl;
  final List<String> options;
  final String questionText;

  QuestionData({
    required this.id,
    required this.imageUrl,
    required this.options,
    required this.questionText,
  });
  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json['id'],
      imageUrl: json['image_url'],
      options: [
        json['option_1'],
        json['option_2'],
        json['option_3'],
        json['option_4']
      ],
      questionText: json['question_text'],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:camera/camera.dart'; // Added camera package
// import 'package:mcqs/Home.dart';
// import 'constants.dart';

// class SessionWithResponse extends StatefulWidget {
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<SessionWithResponse> {
//   late Future<List<QuestionData>> questionData;
//   String? selectedOption;
//   int currentIndex = 0;
//   late CameraController _cameraController; // Added CameraController
//   late List<CameraDescription> cameras;

//   @override
//   void initState() {
//     super.initState();
//     availableCameras().then((availableCameras) {
//       cameras = availableCameras;
//       _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
//       _cameraController.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     });
//     questionData = fetchQuestionData();
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose(); // Dispose camera controller
//     super.dispose();
//   }

//   Future<List<QuestionData>> fetchQuestionData() async {
//     final response = await http.get(Uri.parse('$apiUrl/SessionDetails'));

//     if (response.statusCode == 200) {
//       final List<dynamic> questionData = json.decode(response.body)[0];
//       Future.delayed(Duration(seconds: 2), () {
//         _captureAndSave(selectedOption!);
//       });
//       return questionData.map((e) => QuestionData.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load question');
//     }
//   }

//   Future<void> _captureAndSave(String selectedOption) async {
//     if (_cameraController.value.isInitialized) {
//       XFile? file = await _cameraController.takePicture();
//       String imagePath = file!.path;
//       saveDataToDatabase(imagePath, selectedOption);
//     }
//   }

//   Future<void> saveDataToDatabase(String imagePath, String selectedOption) async {
//     // Here you should implement code to save the picture path and selected option to the database via API

//     final response = await http.post(Uri.parse('$apiUrl/add_patient_session_response'), body: {
//       'imagePath': imagePath,
//       'selectedOption': selectedOption,
//     });
//     if (response.statusCode == 200) {
//       // Data saved successfully
//     } else {
//       // Error handling
//     }
//   }

//   void navigateToHome() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text("Virtual Clinic"),
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: FutureBuilder<List<QuestionData>>(
//           future: questionData,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   if (index == currentIndex) {
//                     return buildQuestionContent(snapshot.data![index]);
//                   } else {
//                     return SizedBox.shrink();
//                   }
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//         bottomNavigationBar: _buildBottomBar(context),
//       ),
//     );
//   }

//   Widget _buildBottomBar(BuildContext context) {
//     return BottomAppBar(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: navigateToHome,
//           ),
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Handle Search Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Handle Notifications Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               // Handle Settings Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward),
//             onPressed: () async {
//               final data = await questionData;
//               setState(() {
//                 currentIndex++;
//                 if (currentIndex >= data.length) {
//                   // Show session end notification
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text("Session End"),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text("OK"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                   currentIndex = 0;
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildQuestionContent(QuestionData data) {
//     return SingleChildScrollView(
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 7),
//         child: Column(
//           children: <Widget>[
//           const  Text(
//               "Look at this picture",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(height: 10),
//             Image.network(data.imageUrl),
//             SizedBox(height: 27),
//             Text(
//               data.questionText,
//               style: TextStyle(fontSize: 16),
//             ),
//             ...List.generate(
//               data.options.length,
//               (index) => RadioListTile<String>(
//                 title: Text(data.options[index]),
//                 value: data.options[index],
//                 groupValue: selectedOption,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedOption = value!;
//                   });
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final data = await questionData;
//                 setState(() {
//                   currentIndex++;
//                   if (currentIndex >= data.length) {
//                     // Show session end notification
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text("Session End"),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text("OK"),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                     currentIndex = 0;
//                   }
//                 });
//               },
//               child: Text('Next'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuestionData {
//   final int id;
//   final String imageUrl;
//   final List<String> options;
//   final String questionText;

//   QuestionData({
//     required this.id,
//     required this.imageUrl,
//     required this.options,
//     required this.questionText,
//   });

//   factory QuestionData.fromJson(Map<String, dynamic> json) {
//     return QuestionData(
//       id: json['id'],
//       imageUrl: json['image_url'],
//       options: [
//         json['option_1'],
//         json['option_2'],
//         json['option_3'],
//         json['option_4']
//       ],
//       questionText: json['question_text'],
//     );
//   }
// }
//--------------------------------------------------------------------------------------
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:camera/camera.dart';
// import 'package:mcqs/Home.dart';
// import 'constants.dart';

// class SessionWithResponse extends StatefulWidget {
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<SessionWithResponse> {
//   late Future<List<QuestionData>> questionData;
//   String? selectedOption;
//   int currentIndex = 0;
//   late CameraController _cameraController;
//   late List<CameraDescription> cameras;

//   @override
//   void initState() {
//     super.initState();
//     availableCameras().then((availableCameras) {
//       cameras = availableCameras;
//       _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
//       _cameraController.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     });
//     questionData = fetchQuestionData();
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   Future<List<QuestionData>> fetchQuestionData() async {
//     final response = await http.get(Uri.parse('$apiUrl/SessionDetails'));

//     if (response.statusCode == 200) {
//       final List<dynamic> questionData = json.decode(response.body)[0];
//       return questionData.map((e) => QuestionData.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load question');
//     }
//   }

//   Future<void> _captureAndSave(String selectedOption) async {
//     if (_cameraController.value.isInitialized) {
//       XFile? file = await _cameraController.takePicture();
//       String imagePath = file!.path;
//       saveDataToDatabase(imagePath, selectedOption);
//     }
//   }

//   Future<void> saveDataToDatabase(
//       String imagePath, String selectedOption) async {
//     final response = await http
//         .post(Uri.parse('$apiUrl/add_patient_session_response'), body: {
//       'imagePath': imagePath,
//       'selectedOption': selectedOption,
//     });
//     if (response.statusCode == 200) {
//       // Data saved successfully
//     } else {
//       // Error handling
//     }
//   }

//   void navigateToHome(String imagePath) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen(imagePath: imagePath)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text("Virtual Clinic"),
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: FutureBuilder<List<QuestionData>>(
//           future: questionData,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   if (index == currentIndex) {
//                     return buildQuestionContent(snapshot.data![index]);
//                   } else {
//                     return SizedBox.shrink();
//                   }
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//         bottomNavigationBar: _buildBottomBar(context),
//       ),
//     );
//   }

//   Widget _buildBottomBar(BuildContext context) {
//     return BottomAppBar(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () {
//               // Handle Home Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Handle Search Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Handle Notifications Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               // Handle Settings Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward),
//             onPressed: () async {
//               final data = await questionData;
//               setState(() {
//                 currentIndex++;
//                 if (currentIndex >= data.length) {
//                   // Last question answered
//                   _captureAndSave(selectedOption!); // Save data
//                   currentIndex = 0; // Reset index
//                   navigateToHome(selectedOption!); // Navigate to next screen
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildQuestionContent(QuestionData data) {
//     return SingleChildScrollView(
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 7),
//         child: Column(
//           children: <Widget>[
//             Text(
//               "Look at this picture",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(height: 10),
//             Image.network(data.imageUrl),
//             SizedBox(height: 27),
//             Text(
//               data.questionText,
//               style: TextStyle(fontSize: 16),
//             ),
//             ...List.generate(
//               data.options.length,
//               (index) => RadioListTile<String>(
//                 title: Text(data.options[index]),
//                 value: data.options[index],
//                 groupValue: selectedOption,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedOption = value!;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuestionData {
//   final int id;
//   final String imageUrl;
//   final List<String> options;
//   final String questionText;

//   QuestionData({
//     required this.id,
//     required this.imageUrl,
//     required this.options,
//     required this.questionText,
//   });

//   factory QuestionData.fromJson(Map<String, dynamic> json) {
//     return QuestionData(
//       id: json['id'],
//       imageUrl: json['image_url'],
//       options: [
//         json['option_1'],
//         json['option_2'],
//         json['option_3'],
//         json['option_4']
//       ],
//       questionText: json['question_text'],
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final String imagePath;

//   const HomeScreen({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Picture from camera:'),
//             SizedBox(height: 20),
//             // Check if imagePath is not null or empty before attempting to load the image
//             imagePath.isNotEmpty && File(imagePath).existsSync() ?
//               Image.file(
//                 File(imagePath),
//                 width: 200,
//                 height: 200,
//               ) :
//               Text('Image not found'), // Display a message if imagePath is empty or the file doesn't exist
//           ],
//         ),
//       ),
//     );
//   }
// }
