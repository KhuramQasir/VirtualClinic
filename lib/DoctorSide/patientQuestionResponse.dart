import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';

class patientQuestionResponse extends StatefulWidget {
  final int phid;

  patientQuestionResponse({required this.phid, required int patient_id});

  @override
  _patientQuestionResponseState createState() => _patientQuestionResponseState();
}

class _patientQuestionResponseState extends State<patientQuestionResponse> {
  late Future<List<dynamic>> _patientSessionResponses;

  @override
  void initState() {
    super.initState();
    _patientSessionResponses = getPatientSessionResponses(widget.phid);
  }

  Future<List<dynamic>> getPatientSessionResponses(int patientHistoryId) async {
    final response = await http.get(Uri.parse('$apiUrl/get_patient_question_response/$patientHistoryId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['Data'] as List<dynamic>;
    } else if (response.statusCode == 404) {
      throw Exception('Data not found');
    } else {
      throw Exception('Failed to load patient session responses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Session Responses'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _patientSessionResponses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: No Data found for this user',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No record found',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            final responses = snapshot.data!;
            return ListView.builder(
              itemCount: responses.length,
              itemBuilder: (context, index) {
                final response = responses[index];
                return ListTile(
                  title: Text(response['question_text']),
                  subtitle: Text('Selected Option: ${response['selected_option']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
