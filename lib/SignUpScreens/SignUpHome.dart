import 'package:flutter/material.dart';
import 'package:mcqs/SignUpScreens/AdminSignup.dart';
import 'package:mcqs/SignUpScreens/DoctorSignup.dart';
import 'package:mcqs/SignUpScreens/PatientSignup.dart';

class SignUpHome extends StatelessWidget {
  const SignUpHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width * 0.7; // Adjust the multiplier to control button width

    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual clinic Psychology'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Admin button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminSignup()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Adjust radius as needed
                  ), backgroundColor: Color.fromARGB(255, 205, 31, 31), // Change button color here
                  elevation: 5, // Set elevation here (adjust as needed)
                ),
                child: Text(
                  'Admin',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Doctor button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorSignup()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Adjust radius as needed
                  ), backgroundColor: Color.fromARGB(255, 44, 89, 173), // Change button color here
                  elevation: 5, // Set elevation here (adjust as needed)
                ),
                child: Text(
                  'Doctor',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Patient button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientSignup()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Adjust radius as needed
                  ), backgroundColor: Colors.green, // Change button color here
                  elevation: 5, // Set elevation here (adjust as needed)
                ),
                child: Text(
                  'Patient',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
