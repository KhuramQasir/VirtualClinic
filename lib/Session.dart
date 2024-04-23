import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/Camera.dart';
import 'package:mcqs/Home.dart';
import 'constants.dart';

class Session extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<Session> {
  late Future<List<QuestionData>> questionData;
  String? selectedOption;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    questionData = fetchQuestionData();
  }

  Future<void> postData({
    required int selectionDetailsId,
    required String selectionOption,
    required int patientHistoryId,
    required File patientResponseImage,
    required String stimuliImg,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$apiUrl/add_patient_session_response'));

      // Add fields to the request
      request.fields['selected_option'] = selectionOption;
      request.fields['session_details_id'] = selectionDetailsId.toString();
      request.fields['patient_history_id'] = patientHistoryId.toString();
      request.fields['stimuli_img'] = stimuliImg;

      // Add image file to the request
      request.files.add(await http.MultipartFile.fromPath('patient_response_image', patientResponseImage.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Data posted successfully');
      } else {
        print('Failed to post data. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<QuestionData>> fetchQuestionData() async {
    final response = await http.get(Uri.parse('$apiUrl/SessionDetails'));

    if (response.statusCode == 200) {
      final List<dynamic> questionData = json.decode(response.body)[0];
      print(json.decode(response.body)[0]);
      return questionData.map((e) => QuestionData.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load question');
    }
  }

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? _capturedImagePath;
  bool isLoading = true;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;

    try {
      Future.delayed(Duration(seconds: 3));
      final image = await _controller.takePicture();
      _capturedImagePath = image.path;
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void main() {
    print(apiUrl);
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
                    return SizedBox.shrink(); // Hide other questions
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
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
          IconButton(icon: Icon(Icons.home), onPressed: navigateToHome),
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
                currentIndex++; // Move to next question
                if (currentIndex >= data.length) {
                  // Reset index if it goes beyond the number of questions
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
      child: FutureBuilder(
        future: questionData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 7),
              child: Column(
                children: <Widget>[
                  Text(
                    "Look at this picture",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Image.network(data.imageUrl),
                  SizedBox(height: 27),
                  Text(
                    snapshot.data[currentIndex].questionText,
                    style: TextStyle(fontSize: 16),
                  ),
                  ...List.generate(
                    snapshot.data[currentIndex].options.length,
                    (index) => RadioListTile<String>(
                      title: Text(snapshot.data[currentIndex].options[index]),
                      value: snapshot.data[currentIndex].options[index],
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        // Move to next question
                        if (currentIndex < snapshot.data.length - 1) {
                          currentIndex++;
                        }
                        _initializeCamera();
                        postData(
                          patientHistoryId: 1,
                          patientResponseImage: File(_capturedImagePath!),
                          selectionDetailsId: 4,
                          selectionOption: selectedOption!,
                          stimuliImg: data.imageUrl,
                        );
                      });
                    },
                    child: Text('Next'),
                  ),
                  Center(
                    child: _capturedImagePath != null
                        ? Image.file(File(_capturedImagePath!))
                        : Container(),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
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
