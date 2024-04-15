import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mcqs/PatientHome.dart';
import 'package:mcqs/constants.dart'; // For apiUrl

class McqsWithResponse extends StatefulWidget {
  @override
  _MCQsState createState() => _MCQsState();
}

class _MCQsState extends State<McqsWithResponse> {
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;
  int currentQuestionIndex = 0;
  String? selectedOption;
  List<Map<String, dynamic>> answers = [];

  @override
  void initState() {
    super.initState();
    fetchQuestions();
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
        'patient_id': 1, // Replace with actual patient ID
        'selected_option': selectedOption,
        'questionnaire_id': 1, // Replace with actual questionnaire ID
      });

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = questions[currentQuestionIndex]['options'][0];
      } else {
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
                  Navigator.push(
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

void main() {
  runApp(MaterialApp(
    home: McqsWithResponse(),
  ));
}
