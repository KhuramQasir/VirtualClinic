import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/DoctorSide/patientDetail.dart';
import 'dart:convert';

import 'package:mcqs/constants.dart';

class DisplayAllPatientsToDoctor extends StatefulWidget {
  final int doctorId;

  DisplayAllPatientsToDoctor({required this.doctorId});

  @override
  _DisplayAllPatientsToDoctorState createState() =>
      _DisplayAllPatientsToDoctorState();
}

class _DisplayAllPatientsToDoctorState
    extends State<DisplayAllPatientsToDoctor> {
  List<Map<String, dynamic>> patientHistoryList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatientHistoryList();
  }

  Future<void> fetchPatientHistoryList() async {
    final url =
        Uri.parse('$apiUrl/getpatienthistorylist/${widget.doctorId}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> patientHistoryData = data[0]['data'];
        final int statusCode = data[1];

        if (statusCode == 200) {
          if (mounted) {
            setState(() {
              patientHistoryList =
                  List<Map<String, dynamic>>.from(patientHistoryData);
              _isLoading = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          print('Failed to load patient history list');
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        print('Failed to load patient history list');
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : patientHistoryList.isEmpty
              ? Center(child: Text("No patient history found"))
              : SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: patientHistoryList.map((patient) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: _buildItem(context, patient),
                      );
                    }).toList(),
                  ),
                ),
    );
  }

  Widget _buildItem(BuildContext context, Map<String, dynamic> patient) {
    return Card(
      color: Colors.green,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient['name'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Disease: ${patient['disease']}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                          return PatientDetailsScreen(patient_id:  patient['id'], );
                    }));
                  },
                  child: Text(
                    'Info',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
