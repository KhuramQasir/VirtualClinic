import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Appointments',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200, // Set a fixed width for the button
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Appointments()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                primary: Colors.green, // Background color
                  onPrimary: Colors.white, // Text color// Set the text color to white
                ),
                child: Text('Check Appoint'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Approve Patient',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ApproveAppointment()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                 primary: Colors.green, // Background color
                  onPrimary: Colors.white, // Text color
                ),
                child: Text('Check'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Session',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/session');
                },
                style: ElevatedButton.styleFrom(
                 primary: Colors.green, // Background color
                  onPrimary: Colors.white, // Text color
                ),
                child: Text('Start Session'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Doctor Ranking',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorRanking()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Background color
                  onPrimary: Colors.white, // Text color
                ),
                child: Text('Doctor Ranking'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Prescrition',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorPrescrition()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Background color
                  onPrimary: Colors.white, // Text color
                ),
                child: Text('View'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
