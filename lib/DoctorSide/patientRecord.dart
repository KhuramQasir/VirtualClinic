import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/DoctorSide/DoctorPrescrition.dart';
import 'package:mcqs/DoctorSide/DoctorSession.dart';
import 'package:mcqs/DoctorSide/patientDetail.dart';
import 'package:mcqs/DoctorSide/patientQuestionResponse.dart';
import 'package:mcqs/constants.dart';

class PatientRcord extends StatefulWidget {
  int pid;
  PatientRcord({required this.pid});
  @override
  _PatientRcordState createState() => _PatientRcordState();
}

class _PatientRcordState extends State<PatientRcord> {
  Future<Map<String, dynamic>>? _reportFuture;

  @override
  void initState() {
    super.initState();
    _reportFuture = fetchPatientReport(widget.pid); // Ensure `pid` is defined and contains the patient ID
  }

  Future<Map<String, dynamic>> fetchPatientReport(int id) async {
    final String url = '$apiUrl/get_patientReport_for_doctor/$id'; // Corrected API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          return data[0];
        } else {
          print('Invalid data format');
          return {};
        }
      } else {
        print('Failed to load patient report: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Set height to fill entire screen
          padding: EdgeInsets.symmetric(horizontal: 22),
          color: Color(0xFF9AE4C9), // Set background color to "#9ae4c9"
          child: FutureBuilder<Map<String, dynamic>>(
            future: _reportFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No report found'));
              } else {
                final report = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                    Text(
                      'Record',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                     SizedBox(height: 40,),
                    Container(
                      margin: EdgeInsets.only(top: 8), // Adjust top margin as needed
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFF5FD4AA), // Set background color to "#5fd4aa"
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: _buildReportContainer(context, report),
                    ),
                     SizedBox(height: 40,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      onPressed: () {
                       Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => patientQuestionResponse(patient_id: patient_id_for_doctor, phid: patient_id_for_doctor,)),
                  );
                },
                     
                      child: Text(
                        "Questionnaire Record",
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      onPressed: () {
                       Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorPrescription())
                  );
                },
                     
                      child: Text(
                        "Set Prescription",
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),


                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildReportContainer(BuildContext context, Map<String, dynamic> report) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField("Disease:", report['disease']),
        SizedBox(height: 24),
        Divider(),
        SizedBox(height: 24),
        _buildTextField("Patient Name:", report['patient_name']),
        SizedBox(height: 23),
        _buildTextField("Gender:", report['gender']),
        SizedBox(height: 23),
        _buildTextField("Session Diagnostics:", report['session_diagnostics'] ?? 'N/A'),
        SizedBox(height: 23),
        _buildTextField("Video Call Diagnostics:", report['video_call_diagnostics'] ?? 'N/A'),
        SizedBox(height: 23),
        _buildTextField("Session Patient History ID:", report['session_patient_history_id'].toString()),
        SizedBox(height: 23),
        _buildTextField("Video Call Patient History ID:", report['video_call_patient_history_id']?.toString() ?? 'N/A'),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(width: 20),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
