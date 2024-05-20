import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/GetStart.dart';
import 'dart:convert';

import 'package:mcqs/PatientHome.dart';
import 'package:mcqs/constants.dart'; // For apiUrl

class McqsWithResponse extends StatefulWidget {
  const McqsWithResponse({Key? key}) : super(key: key);
  @override
  _MCQsState createState() => _MCQsState();
}

class _MCQsState extends State<McqsWithResponse> {
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;
  int currentQuestionIndex = 0;
  String? selectedOption;
  List<Map<String, dynamic>> answers = [];
   List<String> patientdiseaseoption = [];

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }




static callPatientDiseaseAPI(BuildContext context, int patientId, List<String> patientResponses) async {
  try {
    // Your Flask API endpoint URL
    String Url = '$apiUrl/patient_disease';

    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'patient_id': patientId,
      'patient_responses': patientResponses,
    };

    // Make the POST request
    var response = await http.post(
      Uri.parse(Url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    var responseBody = await json.decode(response.body);
    var message = responseBody['message'];

    // Check if request is successful
    if (message != null) {
      // Display a SnackBar with the message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } else {
      // If request failed, return error message
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
     
    }
  } catch (e) {
    // If an exception occurs, return error message
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception occurred: $e'),
        ),
      );
  }
}


  Future<void> sendData(List<Map<String, dynamic>> dataArray) async {
    try {
      final Uri res = Uri.parse('$apiUrl/PatientQuestionnaireResponse');
      final headers = {'Content-Type': 'application/json'};

      // Send the POST request
       // Convert dataArray to JSON
    final jsonData = jsonEncode({'responses': dataArray});

      final response = await http.post(res, headers: headers, body: jsonData);

      // Check the response status
      if (response.statusCode == 200) {
        // Request successful
        print('Data sent successfully');
        answers.clear();
      } else {
        // Request failed
        print('Failed to send data: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error sending data: $error');
    }
  }

  fetchQuestions() async {
    final response = await http.get(Uri.parse('$apiUrl/GetAllQuestionnaire'));
    if (response.statusCode == 200) {
      final List<dynamic> questionData = json.decode(response.body)[0];
      setState(() {
        questions = questionData
            .map((q) => {
                  'question': q['question_text'],
                  'options': [
                    q['option_1'],
                    q['option_2'],
                    q['option_3'],
                    q['option_4']
                  ]
                })
            .toList();
        isLoading = false;
        selectedOption = questions[currentQuestionIndex]['options'][0]; // Set the first option as default
      });
    } else {
      // Handle error
      print('Failed to load questions');
    }
  }

  void handleRadioChange(String? value) {
    setState(() {
      selectedOption = value;
    });
  }

  void handleNextButtonClick() {
    setState(() {
      
      answers.add({
        'patient_id': pid, // Replace with actual patient ID
        'selected_option': selectedOption,
        'questionnaire_id': 6, // Replace with actual questionnaire ID
      }  );
    if (selectedOption != null) {
  patientdiseaseoption.add(selectedOption!); // Adding selectedOption to the list if it's not null
}


print(patientid);
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = questions[currentQuestionIndex]['options'][0];
      } else {
        callPatientDiseaseAPI(context,pid,patientdiseaseoption);
        print(patientdiseaseoption);
        print(answers);
        // Show completion dialog
        sendData(answers);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Quiz Completed'),
            content: const Text('Your quiz is done!'),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigate to PatientHome
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientHome(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCQs'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Make sure you answer each question correctly',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    if (questions.isNotEmpty)
                      Text(
                        questions[currentQuestionIndex]['question'],
                        style: TextStyle(fontSize: 24),
                      ),
                    ...questions[currentQuestionIndex]['options'].map<Widget>((option) {
                      return RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: selectedOption,
                        onChanged: handleRadioChange,
                      );
                    }).toList(),
                    ElevatedButton(
                      onPressed: handleNextButtonClick,
                      child: Text(currentQuestionIndex < questions.length - 1 ? 'Next' : 'Finish'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}