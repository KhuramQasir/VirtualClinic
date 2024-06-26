import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mcqs/DoctorSide/DoctorSidevideoResponse.dart';
import 'package:mcqs/DoctorSide/doctorSessionResponse.dart';
import 'package:mcqs/Super%20Doctor/sessionResponse.dart';
import 'package:mcqs/Super%20Doctor/videoResponse.dart';
import 'package:mcqs/constants.dart';
import 'package:http/http.dart' as http;

class twoButtonsScreenDoctor extends StatefulWidget {
  String date;
  twoButtonsScreenDoctor({required this.date});

  @override
  State<twoButtonsScreenDoctor> createState() => _twoButtonsScreenDoctorState();
}

class _twoButtonsScreenDoctorState extends State<twoButtonsScreenDoctor> {
    late Future<List<dynamic>> _patientSessionResponses;
    
  Future<int?> getSessionIdOnDate(String patientId, String date, String type) async {
    final url = Uri.parse('$apiUrl/getSessionidondate'); // Replace with your actual endpoint
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "patient_id": int.parse(patientId),
      "date": date,
      "type": type,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody is List && responseBody.isNotEmpty) {
          final patientHistoryId = responseBody[0]['patient_history_id'];
          return patientHistoryId;
        } else {
          print('Unexpected response format: $responseBody');
          return null;
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  void fetchPatientHistoryId() async {
    final patientId = patient_id_for_doctor;
    final date = widget.date;
    final type = 'session';

     var patientHistoryId = (await getSessionIdOnDate(patientId.toString(), date, type))!;
    if (patientHistoryId != null) {
      patientHistoryIdforDoctorSide=patientHistoryId;
      print('Patient History ID: $patientHistoryId');
      // setState(() {
      //   _patientSessionResponses = getPatientSessionResponses(patientHistoryId);
      // });
    } else {
      print('Failed to fetch Patient History ID');
      showNoRecordDialog(context);
    }
  }
   void showNoRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Record Found"),
          content: Text("There are no records available."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPatientHistoryId();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(

          child: Center(
            child: Column(
              
              children: [
                SizedBox(height: 100,),
                Container(
                  width: 200,
                  child: ElevatedButton(
                                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Decrease the radius here
                    ),
                  ),
                                ),
                                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                      return DoctorSessionResponse(date: widget.date,);
                  }));
                                },
                                child: Text('Stimuli Session',style: TextStyle(color: Colors.white),),
                              ),
                ),
            SizedBox(height: 20,),
            Container(
                width: 200,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Decrease the radius here
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                      return DoctorVideoResponse(date: widget.date,);
                  }));
                },
                child: Text('Video Response',style: TextStyle(color: Colors.white),),
              ),
            ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
