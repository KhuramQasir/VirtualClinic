import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/VideoSessionlast.dart';
import 'package:path/path.dart' as path; // Add this import
import 'package:mcqs/Home.dart';
import 'constants.dart';

class Session extends StatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  late Future<List<QuestionData>> questionData;
  String? selectedOption;
  int currentIndex = 0;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? _capturedImagePath;
  bool isLoading = true;

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

      // Extract only the file name of the stimuli image
      String stimuliImageName = path.basename(stimuliImg);

      // Add fields to the request
      request.fields['selected_option'] = selectionOption;
      request.fields['session_details_id'] = selectionDetailsId.toString();
      request.fields['patient_history_id'] = patientHistoryId.toString();
      request.fields['stimuli_img'] = stimuliImageName;

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
      return questionData.map((e) => QuestionData.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load question');
    }
  }

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
      await Future.delayed(Duration(seconds: 3));
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

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Completed'),
        content: Text('You have reached the end of the questions.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => VideoSessionLast()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
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
            } else {
              return Center(child: Text("No data found"));
            }
          },
        ),
        // bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.home), onPressed: navigateToHome),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              final data = await questionData;
              if (currentIndex < data.length - 1) {
                setState(() {
                  currentIndex++; // Move to next question
                  _initializeCamera();
                });
              } else {
                _showCompletionDialog();
              }
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Look at this picture",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              width: 500,height: 300,
              child: Image.network(data.imageUrl)),
            SizedBox(height: 20),
            Text(
              data.questionText,
              
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            
            ...data.options.asMap().entries.map((entry) {
              int idx = entry.key;
              String option = entry.value;
              return RadioListTile<String>(
                title: Text(option),
                value: 'option_${idx + 1}',
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value!;
                  });
                },
              );
            }).toList(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedOption != null) {
                    await postData(
                      selectionDetailsId: data.id,
                      selectionOption: selectedOption!,
                      patientHistoryId: phid,
                      patientResponseImage: File(_capturedImagePath!),
                      stimuliImg: data.imageUrl,
                    );
                    if (currentIndex < (await questionData).length - 1) {
                      setState(() {
                        currentIndex++;
                        selectedOption = null;
                      });
                      _initializeCamera();
                    } else {
                      _showCompletionDialog();
                    }
                  }
                },
                child: Text('Next'),
              ),
            ),
            // Center(
            //   child: _capturedImagePath != null
            //       ? Image.file(File(_capturedImagePath!))
            //       : Container(),
            // ),
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
