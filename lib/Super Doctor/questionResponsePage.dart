import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';

class QuestionResponsePage extends StatefulWidget {
  final int patientId;

  const QuestionResponsePage({Key? key, required this.patientId}) : super(key: key);

  @override
  _QuestionResponsePageState createState() => _QuestionResponsePageState();
}

class _QuestionResponsePageState extends State<QuestionResponsePage> {
  late Future<List<QuestionResponse>> futureQuestionResponses;

  @override
  void initState() {
    super.initState();
    futureQuestionResponses = fetchQuestionResponses(widget.patientId);
  }

  Future<List<QuestionResponse>> fetchQuestionResponses(int patientId) async {
    final response = await http.get(Uri.parse('$apiUrl/get_patient_question_response/$patientId'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> questionResponsesData = responseData[0]['Data'];
      return questionResponsesData.map((response) => QuestionResponse.fromJson(response)).toList();
    } else {
      throw Exception('Failed to load question responses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Responses'),
      ),
      body: Column(
        children: [
          
          Expanded(
            child: FutureBuilder<List<QuestionResponse>>(
              future: futureQuestionResponses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No question responses found'));
                } else {
                  final questionResponses = snapshot.data!;
                  return ListView.builder(
                    itemCount: questionResponses.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.green,
                        child: ListTile(
                          title: Text(
                            questionResponses[index].questionText,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            'Selected Option: ${questionResponses[index].selectedOption}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionResponse {
  final String questionText;
  final String selectedOption;

  QuestionResponse({
    required this.questionText,
    required this.selectedOption,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      questionText: json['question_text'],
      selectedOption: json['selected_option'],
    );
  }
}
