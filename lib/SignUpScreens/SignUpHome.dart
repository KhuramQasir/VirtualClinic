import 'package:flutter/material.dart';
import 'package:mcqs/SignUpScreens/AdminSignup.dart';
import 'package:mcqs/SignUpScreens/DoctorSignup.dart';
import 'package:mcqs/SignUpScreens/PatientSignup.dart';

class SignUpHome extends StatelessWidget {
   const SignUpHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User Type'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle Admin button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminSignup())
              );
            },
            child: Text('Admin'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle Doctor button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorSignup()),
              );
            },
            child: Text('Doctor'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle Patient button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientSignup()),
              );
            },
            child: Text('Patient'),
          ),
        ],
      ),
    );
  }
}




