import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';

class PatientSessionResponsesScreen extends StatefulWidget {
  int phid;
  PatientSessionResponsesScreen({required this.phid});

  @override
  _PatientSessionResponsesScreenState createState() =>
      _PatientSessionResponsesScreenState();
}

class _PatientSessionResponsesScreenState
    extends State<PatientSessionResponsesScreen> {
  late Future<List<dynamic>> _patientSessionResponses;
  int currentIndex = 0;
  late List<dynamic> _responses; // Declare _responses here

  @override
  void initState() {
    super.initState();
    _patientSessionResponses = getPatientSessionResponses(widget.phid);
  }

  Future<List<dynamic>> getPatientSessionResponses(int patientHistoryId) async {
    final response =
        await http.get(Uri.parse('$apiUrl/get_patient_session_responses/$patientHistoryId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      print(data); // Print the raw API response to the console
      return data[0]['data']; // Accessing the list of responses
    } else if (response.statusCode == 404) {
      final data = jsonDecode(response.body) as List<dynamic>;
      if (data.isNotEmpty && data[0]['message'] == "Data not found") {
        print("Data not found"); // Print the message to the console
        return []; // Return an empty list since data is not found
      } else {
        throw Exception('Failed to load patient session responses');
      }
    } else {
      throw Exception('Failed to load patient session responses');
    }
  }

  void onNextPressed() {
    setState(() {
      if (currentIndex < _responses.length - 1) {
        currentIndex++;
        print(_responses[currentIndex]['diagnostic']); // Print diagnostic after pressing Next
      } else {
        // Handle end of questions
        print("End of responses.");
      }
    });
  }

  void showNoRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Record Found"),
          content: Text("There are no records available."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Patient Session Responses'),
    ),
    body: SingleChildScrollView(
      child: FutureBuilder<List<dynamic>>(
        future: _patientSessionResponses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: No Data Found ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No record found',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            _responses = snapshot.data!; // Assign data to _responses
            final response = _responses[currentIndex];
            return Column(
              children: [
                // Display the image above the question
                Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        '$apiUrl/${response['stimuli_image']}',
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between images
                    Expanded(
                      child: Image.network(
                        '$apiUrl/${response['patient_response_image']}',
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Add spacing
                Text(response['question_text']),
                Column(
                  children: [
                    RadioListTile<String>(
                      title: Text(response['option_1']),
                      value: response['option_1'],
                      groupValue: response['selected_option'],
                      onChanged: (value) {
                        setState(() {
                          response['selected_option'] = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(response['option_2']),
                      value: response['option_2'],
                      groupValue: response['selected_option'],
                      onChanged: (value) {
                        setState(() {
                          response['selected_option'] = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(response['option_3']),
                      value: response['option_3'],
                      groupValue: response['selected_option'],
                      onChanged: (value) {
                        setState(() {
                          response['selected_option'] = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(response['option_4']),
                      value: response['option_4'],
                      groupValue: response['selected_option'],
                      onChanged: (value) {
                        setState(() {
                          response['selected_option'] = value!;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: onNextPressed,
                  child: Text('Next'),
                ),
                SizedBox(height: 10,),
                  Container(
                    color: Colors.red,
                    height: 50,
                    width: 300,
                    child: Center(
                      child: Text(
                        response['diagnostic'],
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white), // Adjust the font size as needed
                      ),
                    ),
                  )
              ],
            );
          }
        },
      ),
    ),
  );
}
    }