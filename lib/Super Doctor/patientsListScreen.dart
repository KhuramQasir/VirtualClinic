import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart'; // Assuming constants.dart contains your apiUrl
import 'package:mcqs/Super%20Doctor/prescriptionListPage.dart';

class PatientsListPage extends StatefulWidget {
  final int doctorId;

  const PatientsListPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  _PatientsListPageState createState() => _PatientsListPageState();
}

class _PatientsListPageState extends State<PatientsListPage> {
  late Future<List<Patient>> futurePatients;

  @override
  void initState() {
    super.initState();
    futurePatients = fetchPatients(widget.doctorId);
  }

  Future<List<Patient>> fetchPatients(int doctorId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/get_require_ranking_patients/$doctorId'),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is List && responseData.length >= 2) {
          final List<dynamic> patientsData = responseData[0]['data']['patients'];
          var patients = patientsData.map((patientJson) => Patient.fromJson(patientJson)).toList();
          return patients.cast<Patient>();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load patients: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching patients: $e');
      return []; // Return empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
      ),
      body: FutureBuilder<List<Patient>>(
        future: futurePatients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No patients found'));
          } else {
            final patients = snapshot.data!;
            return ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green,
                  child: ListTile(
                    title: Text(
                      patients[index].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      'Disease: ${patients[index].disease}',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrescriptionListPage(
                              patientId: patients[index].pid,
                              did: widget.doctorId,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Info',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Patient {
  final String name;
  final String disease;
  final int id;
  final int pid;
  final int doctorId;

  Patient({
    required this.pid,
    required this.name,
    required this.disease,
    required this.id,
    required this.doctorId,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      pid: json['Patient_id'] ?? '',
      name: json['name'] ?? '',
      disease: json['disease'] ?? '',
      id: json['Patient_id'] ?? 0,
      doctorId: json['doctor_id'] ?? 0,
    );
  }
}
