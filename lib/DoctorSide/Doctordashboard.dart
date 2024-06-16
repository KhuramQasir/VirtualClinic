import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mcqs/DoctorSide/AddQuestion.dart';
import 'package:mcqs/DoctorSide/ApprovePatient.dart';
import 'package:mcqs/DoctorSide/DoctorAppointment.dart';
import 'package:mcqs/DoctorSide/DoctorPrescrition.dart';
import 'package:mcqs/Super%20Doctor/DoctorRating.dart';
import 'package:mcqs/DoctorSide/DoctorSession.dart';
import 'package:mcqs/DoctorSide/DoctorVideoCall.dart';
import 'package:mcqs/DoctorSide/SelectQuestion.dart';
import 'package:mcqs/DoctorSide/doctorAllPatient.dart';
import 'package:mcqs/DoctorSide/patientHistoryforDoctoe.dart';
import 'package:mcqs/PatientMontlySchedule.dart';
import 'package:mcqs/PatientReport.dart';
import 'package:mcqs/Session.dart';
import 'package:mcqs/UploadVideo.dart';
import 'package:mcqs/VideoCall.dart';
import 'package:mcqs/constants.dart';


class Doctordashboard extends StatefulWidget {
  const Doctordashboard({Key? key}) : super(key: key);

  @override
  _DoctordashboardState createState() => _DoctordashboardState();
}

class _DoctordashboardState extends State<Doctordashboard> {
  @override
  void initState() {
    super.initState();
    checkPatientSchedule();
    print('Doctor Id = $doctor_id_d');
  }

  Future<void> checkPatientSchedule() async {
    final int doctorId = doctor_id_d; // Replace with actual doctor ID
    final response = await http.get(Uri.parse('$apiUrl/DoctorRoster/$doctorId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final patients = data[0]['data']['Patients'];
      final currentTime = DateTime.now();

      for (var patient in patients) {
        final startTime = DateFormat.Hms().parse(patient['start_time']);
        final endTime = DateFormat.Hms().parse(patient['end_time']);
        final startTimeToday = DateTime(currentTime.year, currentTime.month, currentTime.day, startTime.hour, startTime.minute, startTime.second);
        final endTimeToday = DateTime(currentTime.year, currentTime.month, currentTime.day, endTime.hour, endTime.minute, endTime.second);

        if (currentTime.isAfter(startTimeToday) && currentTime.isBefore(endTimeToday)) {
            setState(() {
            patient_id_for_doctor = patient['Patient_id'];
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Patient Schedule'),
                content: Text('Patient ID: ${patient['Patient_id']}\nPatient: ${patient['patientName']}\nDisease: ${patient['disease']}\nTime: ${patient['start_time']} - ${patient['end_time']}'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          break;
        }
      }
    } else {
      print('Failed to load patient schedule');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),

           Container(
            
            decoration: BoxDecoration(
              borderRadius:BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),

              color: Colors.white,
              boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],),
          width: 300,
          height: 105,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text(
                        'Appointments',
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Patients to Check Today',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorAppointment()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                  child: Text('Check Appoint'),
                ),
              ),

            ],
          ),
        ),








        SizedBox(height: 30,),
         Container(
            
            decoration: BoxDecoration(
              borderRadius:BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),

              color: Colors.white,
              boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],),
          width: 300,
          height: 105,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text(
                        'Approve Patient',
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Give your approval to treat the patient',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  
                ),
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApprovePatient()),
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                  child: Text('Check Appoint'),
                ),
              ),

            ],
          ),
        ),
        
          


           SizedBox(height: 30,),
        
         Container(
            
            decoration: BoxDecoration(
              borderRadius:BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),

              color: Colors.white,
              boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],),
          width: 300,
          height: 105,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text(
                        'Add Question',
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Add Question',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  
                ),
                child: ElevatedButton(
                  onPressed: () {
                   
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddQuestion()),
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                  child: Text('Questions'),
                ),
              ),

            ],
          ),
        ),







SizedBox(height: 30,),
         Container(
            
            decoration: BoxDecoration(
              borderRadius:BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),

              color: Colors.white,
              boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],),
          width: 300,
          height: 105,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text(
                        'Patient Records',
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      'See all detail of Patient',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DisplayAllPatientsToDoctor(doctorId: doctor_id_d,)),
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                  child: Text('View'),
                ),
              ),

            ],
          ),
        ),




          ],
        ),
      ),
    ),
    );
    
  }
}
