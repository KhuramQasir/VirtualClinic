import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';

class PatientDetailsScreen extends StatefulWidget {
  int patient_id;
  PatientDetailsScreen({required this.patient_id});
  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  late Future<Map<String, dynamic>> _patientFuture;

  @override
  void initState() {
    super.initState();
    _patientFuture = getPatient(widget.patient_id);
  }

  Future<Map<String, dynamic>> getPatient(int id) async {
    final url = Uri.parse('$apiUrl/get-patient/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get patient');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _patientFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final patientData = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text('Name: ${patientData['name']}'),
                ),
                ListTile(
                  title: Text('Age: ${patientData['age']}'),
                ),
                ListTile(
                  title: Text('CNIC: ${patientData['cnic']}'),
                ),
                ListTile(
                  title: Text('Disease Name: ${patientData['disease_name']}'),
                ),
                ListTile(
                  title: Text('Gender: ${patientData['gender']}'),
                ),
                ListTile(
                  title: Text('ID: ${patientData['id']}'),
                ),
                ListTile(
                  title: Text('User ID: ${patientData['user_id']}'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
