import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/AdminSide/AllPatients.dart';
import 'package:mcqs/constants.dart';

Future<Map<String, dynamic>> fetchPatientById(int id) async {
  final url = Uri.parse('$apiUrl/get-patient/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
      return data[0] as Map<String, dynamic>;
    } else {
      throw Exception('Patient data is not in the expected format');
    }
  } else {
    throw Exception('Failed to load Patient data');
  }
}

Future<void> updatePatientProfile({
  required BuildContext context,
  required String name,
  required String email,
  required String dob,
  required String gender,
  required String password,
  required String cnic,
  required int patientId,
  required int userId,
}) async {
  final url = Uri.parse('$apiUrl/Patientupdateprofile'); // Replace with your actual API endpoint

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'name': name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'password': password,
      'cnic': cnic,
      'patient_id': patientId,
      'user_id': userId,
    }),
  );

  if (response.statusCode == 200) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Updated Successfully'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AllPatients();
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  } else {
    print('Failed to update profile: ${response.reasonPhrase}');
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fail'),
          content: Text('Failed to update profile: ${response.reasonPhrase}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AllPatients();
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class PatientInfo extends StatefulWidget {
  final int adminId;

  PatientInfo({required this.adminId});

  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  Map<String, dynamic>? patientData;
  bool isLoading = true;

  TextEditingController? nameController;
  TextEditingController? cityController;
  TextEditingController? cnicController;
  TextEditingController? dobController;
  TextEditingController? idController;
  TextEditingController? userIdController;

  String? selectedGender;

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
        nameController = TextEditingController(text: patientData!['name']);
        cityController = TextEditingController(text: patientData!['city']);
        cnicController = TextEditingController(text: patientData!['cnic']);
        dobController = TextEditingController(text: patientData!['dob']);
        selectedGender = patientData!['gender'];
        idController = TextEditingController(text: patientData!['id'].toString());
        userIdController = TextEditingController(text: patientData!['user_id'].toString());
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching patient data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController?.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : patientData != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        TextField(
                          controller: cityController,
                          decoration: InputDecoration(
                            labelText: 'City',
                          ),
                        ),
                        TextField(
                          controller: cnicController,
                          decoration: InputDecoration(
                            labelText: 'CNIC',
                          ),
                        ),
                        TextField(
                          controller: dobController,
                          decoration: InputDecoration(
                            labelText: 'DOB',
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gender'),
                            RadioListTile<String>(
                              title: const Text('Male'),
                              value: 'Male',
                              groupValue: selectedGender,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('Female'),
                              value: 'Female',
                              groupValue: selectedGender,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('Other'),
                              value: 'Other',
                              groupValue: selectedGender,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                          ],
                        ),
                        TextField(
                          controller: idController,
                          decoration: InputDecoration(
                            labelText: 'ID',
                          ),
                        ),
                        TextField(
                          controller: userIdController,
                          decoration: InputDecoration(
                            labelText: 'User ID',
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // background color
                              onPrimary: Colors.white, // text color
                            ),
                            onPressed: () {
                              updatePatientProfile(
                                context: context,
                                name: nameController!.text,
                                email: cityController!.text,
                                dob: dobController!.text,
                                gender: selectedGender!,
                                password: 'password', // Use the actual password value here
                                cnic: cnicController!.text,
                                patientId: int.parse(idController!.text),
                                userId: int.parse(userIdController!.text),
                              );
                            },
                            child: Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(child: Text('Failed to load Patient data')),
    );
  }
}
