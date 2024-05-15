import 'package:flutter/material.dart';
import 'package:mcqs/DoctorSide/Appointments.dart';
import 'package:mcqs/DoctorSide/ApproveApointment.dart';
import 'package:mcqs/DoctorSide/DoctorPrescrition.dart';
import 'package:mcqs/DoctorSide/DoctorRating.dart';
import 'package:mcqs/PatientMontlySchedule.dart';
import 'package:mcqs/PatientReport.dart';
import 'package:mcqs/Session.dart';
import 'package:mcqs/UploadVideo.dart';

import 'package:mcqs/VideoCall.dart';



class Doctordashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Doctor'),
        ),
        body: ConsultationScreen(),
      ),
      routes: {
       '/session': (context) => Session(),
       // Define route for Session Screen
      },
    );
  }
}

class ConsultationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Appointments',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              // Action for Start Video button
             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Appointments())
                              )
                              ;
            },
            child: Text('Check Appoint '),
          ),
          SizedBox(height: 20),
          Text(
            'Approve Patient',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to Session Screen when button pressed
             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ApproveAppointment())
                              )
                              ;
            },
            child: Text('Check'),
          ),
          
          SizedBox(height: 20),
          Text(
            'Session',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
             Navigator.pushNamed(context, '/session');
            },
            child: Text('Start Session'),
          ),
          SizedBox(height: 20),
          Text(
            'Doctor Ranking',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              // Action for Start Video button
             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DoctorRanking())
                              )
                              ;
            },
            child: Text('Doctor Ranking'),
          ),
          SizedBox(height: 20),
          Text(
            'Prescrition',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              // Action for Check Report button
               Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DoctorPrescrition())
                              )
                              ;
            },
            child: Text('View'),
          ),
        ],
      ),
    );
  }
}


