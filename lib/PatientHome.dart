import 'package:flutter/material.dart';
import 'package:mcqs/PatientMontlySchedule.dart';
import 'package:mcqs/PatientReport.dart';
import 'package:mcqs/Session.dart';
import 'package:mcqs/UploadVideo.dart';
import 'package:mcqs/VideoCall.dart';


class PatientHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Consultation Screen'),
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
          Text(
            'Consultations',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 200, // Set a fixed width for all buttons
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Session Screen when button pressed
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientSchedulesScreen()));
              },
              child: Text('View Appointments'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green, // Set text color to white
              ),
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
              child: Text('Start Session'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Video Call',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Action for Start Video button
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Upload()));
              },
              child: Text('Start Video'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Report',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Action for Check Report button
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientReport()));
              },
              child: Text('Check Report'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
