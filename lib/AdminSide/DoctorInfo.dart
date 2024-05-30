import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/AdminSide/AllDoctor.dart';
import 'package:mcqs/constants.dart';

class DoctorInfo extends StatefulWidget {
  final int adminId;

  DoctorInfo({required this.adminId});

  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  Map<String, dynamic>? patientData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatientData();
  }

  Future<void> fetchPatientData() async {
    try {
      final data = await fetchPatientById(widget.adminId);
      setState(() {
        patientData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching patient data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Details'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : patientData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${patientData!['name']}'),
                      Text('Qualification: ${patientData!['qualification']}'),
                      Text('CNIC: ${patientData!['cnic']}'),
                      Text('DOB: ${patientData!['dob']}'),
                      Text('Experience Years: ${patientData!['experience_years']}'),
                      Text('Gender: ${patientData!['gender']}'),
                      Text('ID: ${patientData!['id']}'),
                      Text('User ID: ${patientData!['user_id']}'),
                      Text('Approved: ${patientData!['approved']}'),
                      // Do not display the password for security reasons
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            approveDoctor(context, patientData!['id']);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                          ),
                          child: Text('Approve Doctor'),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: Text('Failed to load Doctor data')),
    );
  }

  Future<Map<String, dynamic>> fetchPatientById(int id) async {
    final url = Uri.parse('$apiUrl/get-doctor/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
        return data[0] as Map<String, dynamic>;
      } else {
        throw Exception('Doctor data is not in the expected format');
      }
    } else {
      throw Exception('Failed to load Doctor data');
    }
  }

  Future<void> approveDoctor(BuildContext context, int id) async {
    final url = Uri.parse('$apiUrl/Approve-doctor/$id');
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "role": "junior_doctor",
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
       

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Approval Successful'),
                content: Text('Approved'),
                actions: [
                  TextButton(
                    onPressed: () {
                       Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AllDoctor()),
                  );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to approve doctor. Status code: ${response.statusCode}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while approving the doctor.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
