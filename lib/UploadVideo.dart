import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcqs/UploadVideo/Model.dart';
import 'package:mcqs/constants.dart';
import 'package:http/http.dart' as http;

final picker = ImagePicker();

class Upload extends StatefulWidget {
  const Upload();

  @override
  State<Upload> createState() => _UploadState();
}

Future<void> postData({
  required BuildContext context,
  required String Question,
  required int PatientHistoryId,
  required File Videofile,
}) async {
  try {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiUrl/PatientVideoCallResponse'));

    // Add fields to the request
    request.fields['question'] = Question.toString();
    request.fields['patient_history_id'] = PatientHistoryId.toString();

    // Add video file to the request
    request.files
        .add(await http.MultipartFile.fromPath('videofile', Videofile.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video Uploaded Successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to Upload Video. Error: ${response.reasonPhrase}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

class _UploadState extends State<Upload> {
  void _showPicker({
    required BuildContext context,
    required int index,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  getVideo(ImageSource.gallery, index);
                  Navigator.of(context).pop(); // close the bottom sheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getVideo(ImageSource.camera, index);
                  Navigator.of(context).pop(); // close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getVideo(ImageSource source, int index) async {
    final pickedFile = await picker.pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: const Duration(minutes: 10),
    );
    setState(() {
      if (pickedFile != null) {
        questions[index].videoFile = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Clinic'),
        backgroundColor: Colors.green,
        actions: const [],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      questions[index].Q,
                      style: TextStyle(fontSize: 18),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: const Text('Select video'),
                      onPressed: () {
                        _showPicker(context: context, index: index);
                      },
                    ),
                    if (questions[index].videoFile != null)
                      Text(
                        'File path: ${questions[index].videoFile!.path}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: const Text('Upload'),
                      onPressed: () {
                        if (questions[index].videoFile != null) {
                          postData(
                            context: context,
                            PatientHistoryId: phid,
                            Question: questions[index].Q,
                            Videofile: File(questions[index].videoFile!.path),
                          );

                          setState(() {
                            questions[index].videoFile = null;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('No video selected to upload')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
