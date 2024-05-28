import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mcqs/Home.dart';
import 'package:mcqs/Super%20Doctor/home.dart';
import 'package:mcqs/constants.dart';

class DoctorRanking extends StatefulWidget {
  final int pid;
  final int did;
  DoctorRanking({required this.did, required this.pid});

  @override
  _DoctorRankingState createState() => _DoctorRankingState();
}

TextEditingController editTextController = TextEditingController();

class _DoctorRankingState extends State<DoctorRanking> {
  int? selectedRating;

  Future<void> submitDoctorRanking({
    required int doctorId,
    required int seniorDoctorId,
    required String feedback,
    required int patientHistoryId,
    required int rating,
  }) async {
    final url = Uri.parse('$apiUrl/doctor_ranking');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'doctor_id': doctorId,
        'senior_doctor_id': seniorDoctorId,
        'feedback': feedback,
        'patient_id': patientHistoryId,
        'rating': rating,
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Ranking Added Successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return SuperDoctorHome();
                  }));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      throw Exception('Failed to submit doctor ranking: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 18),
              Text("Doctor Rating", style: TextStyle(fontSize: 25)),
              SizedBox(height: 20),
              _buildView1(context, 1),
              SizedBox(height: 20),
              _buildView2(context, 2),
              SizedBox(height: 20),
              _buildView3(context, 3),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 47),
                  child: Text("Feedback:"),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13),
                child: TextFormField(
                  controller: editTextController,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colors.white), // Text color
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green, // Background color
                    hintText: 'Feedback',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 34, horizontal: 20),
                  ),
                ),
              ),
              SizedBox(height: 61),
              ElevatedButton(
                onPressed: () {
                  if (selectedRating != null) {
                    submitDoctorRanking(
                      doctorId: widget.did,
                      seniorDoctorId: senior_doctor_id,
                      feedback: editTextController.text,
                      patientHistoryId: widget.pid,
                      rating: selectedRating!,
                    ).catchError((error) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to submit rating: $error'),
                            actions: <Widget>[
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
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please select a rating.'),
                          actions: <Widget>[
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
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  fixedSize: Size(127, 36),
                ),
                child: Text("Rate"),
              ),
              SizedBox(height: 19),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildView1(BuildContext context, int row) {
    return Row(
      children: [
        Radio<int>(
          value: row,
          groupValue: selectedRating,
          onChanged: (value) {
            setState(() {
              selectedRating = value;
            });
          },
        ),
        SizedBox(width: 16),
        Icon(Icons.star, size: 20),
      ],
    );
  }

  Widget _buildView2(BuildContext context, int row) {
    return Row(
      children: [
        Radio<int>(
          value: row,
          groupValue: selectedRating,
          onChanged: (value) {
            setState(() {
              selectedRating = value;
            });
          },
        ),
        SizedBox(width: 16),
        Icon(Icons.star, size: 20),
        SizedBox(width: 4),
        Icon(Icons.star, size: 20),
      ],
    );
  }

  Widget _buildView3(BuildContext context, int row) {
    return Row(
      children: [
        Radio<int>(
          value: row,
          groupValue: selectedRating,
          onChanged: (value) {
            setState(() {
              selectedRating = value;
            });
          },
        ),
        SizedBox(width: 16),
        Icon(Icons.star, size: 20),
        SizedBox(width: 4),
        Icon(Icons.star, size: 20),
        SizedBox(width: 4),
        Icon(Icons.star, size: 20),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      child: Container(height: 56),
    );
  }
}
