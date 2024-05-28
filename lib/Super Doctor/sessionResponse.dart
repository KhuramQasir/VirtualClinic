import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mcqs/constants.dart';

class SuperDoctorSessionResponse extends StatefulWidget {
  final String patientid, date;

  SuperDoctorSessionResponse({required this.date, required this.patientid});

  @override
  State<SuperDoctorSessionResponse> createState() => _SuperDoctorSessionResponseState();
}

class _SuperDoctorSessionResponseState extends State<SuperDoctorSessionResponse> {
  late Future<List<dynamic>> _patientSessionResponses;
  List<dynamic> _responses = [];
  int currentIndex = 0;
  int patientHistoryId=0;

  Future<int?> getSessionIdOnDate(String patientId, String date, String type) async {
    final url = Uri.parse('$apiUrl/getSessionidondate'); // Replace with your actual endpoint
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "patient_id": int.parse(patientId),
      "date": date,
      "type": type,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody is List && responseBody.isNotEmpty) {
          final patientHistoryId = responseBody[0]['patient_history_id'];
          return patientHistoryId;
        } else {
          print('Unexpected response format: $responseBody');
          return null;
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<dynamic>> getPatientSessionResponses(int patientHistoryId) async {
    final response = await http.get(Uri.parse('$apiUrl/get_patient_session_responses/$patientHistoryId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      print(data); // Print the raw API response to the console
      return data[0]['data']; // Accessing the list of responses
    } else if (response.statusCode == 404) {
      final data = jsonDecode(response.body) as List<dynamic>;
      if (data.isNotEmpty && data[0]['message'] == "Data not found") {
        print("Data not found");
        return [];
      } else {
        throw Exception('Failed to load patient session responses');
      }
    } else {
      throw Exception('Failed to load patient session responses');
    }
  }

  void fetchPatientHistoryId() async {
    final patientId = widget.patientid;
    final date = widget.date;
    final type = 'session';

     patientHistoryId = (await getSessionIdOnDate(patientId, date, type))!;
    if (patientHistoryId != null) {
      print('Patient History ID: $patientHistoryId');
      setState(() {
        _patientSessionResponses = getPatientSessionResponses(patientHistoryId);
      });
    } else {
      print('Failed to fetch Patient History ID');
      showNoRecordDialog(context);
    }
  }

  void onNextPressed() {
    setState(() {
      if (currentIndex < _responses.length - 1) {
        currentIndex++;
        print(_responses[currentIndex]['diagnostic']); // Print diagnostic after pressing Next
      } else {
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
  void initState() {
    super.initState();
    fetchPatientHistoryId();
    _patientSessionResponses = Future.value([]); // Initialize with empty list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stimuli Response'),),
      body: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>>(
          future: _patientSessionResponses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: No Data Found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No record found',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              _responses = snapshot.data!;
              final response = _responses[currentIndex];
              return Column(
                children: [
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
                      SizedBox(width: 10),
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
                  SizedBox(height: 20),
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
