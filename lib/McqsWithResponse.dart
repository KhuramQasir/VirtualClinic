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
  List<String> firstList = []; // To store selected options
  List<String> secondList = []; // To store option identifiers

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  static callPatientDiseaseAPI(BuildContext context, int patientId, List<String> patientResponses) async {
    try {
      String url = '$apiUrl/patient_disease';
      Map<String, dynamic> requestBody = {
        'patient_id': patientId,
        'patient_responses': patientResponses,
      };

      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      var responseBody = json.decode(response.body);
      var message = responseBody['message'];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ?? 'No message'),
        ),
      );
    } catch (e) {
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
      final jsonData = jsonEncode({'responses': dataArray});

      final response = await http.post(res, headers: headers, body: jsonData);

      if (response.statusCode == 200) {
        print('Data sent successfully');
        answers.clear();
      } else {
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
                  'question_id': q['id'],
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
        selectedOption = questions[currentQuestionIndex]['options'][0];
      });
    } else {
      print('Failed to load questions');
    }
  }

  void handleRadioChange(String? value) {
    setState(() {
      selectedOption = value;
    });
  }

  void handleNextButtonClick() {
    if (selectedOption != null) {
      firstList.add(selectedOption!); // Add selected option to firstList

      // Find index of selected option
      int selectedIndex = questions[currentQuestionIndex]['options'].indexOf(selectedOption!);

      // Add identifier to secondList based on selectedIndex
      if (selectedIndex >= 0) {
        secondList.add('option_${selectedIndex + 1}');
      }

      print('First List: $firstList');
      print('Second List: $secondList');
    }

    setState(() {
      answers.add({
        'patient_id': pid, // Replace with actual patient ID
        'selected_option': secondList[currentQuestionIndex],
        'questionnaire_id': questions[currentQuestionIndex]['question_id'], // Replace with actual questionnaire ID
      });

      if (selectedOption != null) {
        patientdiseaseoption.add(selectedOption!);
      }

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = questions[currentQuestionIndex]['options'][0];
      } else {
        callPatientDiseaseAPI(context, pid, firstList);
        print(patientdiseaseoption);
        print(answers);
        sendData(answers);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Quiz Completed'),
            content: const Text('Your quiz is done!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetStart(),
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
