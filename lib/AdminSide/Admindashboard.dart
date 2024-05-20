import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/AdminSide/AdminAproveRegistration.dart';
import 'package:mcqs/AdminSide/AdminPatinetInfo.dart';
import 'package:mcqs/AdminSide/AdminPatinettableInfo.dart';
import 'package:mcqs/AdminSide/AllDoctor.dart';
import 'package:mcqs/AdminSide/AllPatients.dart';
import 'package:mcqs/constants.dart';
import 'dart:convert';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Patients',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Admindashboard(),
    );
  }
}

Future<int> fetchAllPatientsCount() async {
  final response = await http.get(Uri.parse('$apiUrl/AllPatients'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data[0].length; // Assuming the first element contains the list of patients
  } else {
    throw Exception('Failed to load patients');
  }
}

Future<int> fetchAllDoctorCount() async {
  final response = await http.get(Uri.parse('$apiUrl/AllDoctors'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data[0].length; // Assuming the first element contains the list of doctors
  } else {
    throw Exception('Failed to load doctors');
  }
}

class Admindashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<int> futurePatientsCount = fetchAllPatientsCount();
    Future<int> futureDoctorsCount = fetchAllDoctorCount();
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildAdminOfClinic(),
            SizedBox(height: 20),
            FutureBuilder<int>(
              future: futurePatientsCount,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return _buildTotalPatientS(
                    context,
                    totalPatientS: "Total Patient’s",
                    count: snapshot.data.toString(),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
            SizedBox(height: 40),
            FutureBuilder<int>(
              future: futureDoctorsCount,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return _buildTotalDoctor(
                    context,
                    totalPatientS: "Total Doctors’s",
                    count: snapshot.data.toString(),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
            SizedBox(height: 40),
            Text(
              "Total Doctors OverView",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildButtonViewDoctors(context, "View Doctors"),
            SizedBox(height: 10),
            Text(
              "Patient Matrics",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            _buildButtonViewPatients(context, "View Patients"),
            SizedBox(height: 10),
            Text(
              "Registrations Approval",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildButtonReviewRegistrations(context, "Review Registrations"),
            SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPatientInfo()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => AdminDoctortableInfo()));
              },
            ),
            IconButton(
              icon: Icon(Icons.lock),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPatienttableInfo()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAdminOfClinic() {
    return ListTile(
      title: Text("Admin of Clinic", style: TextStyle(fontSize: 18)),
      leading: CircleAvatar(child: Icon(Icons.person)),
      trailing: Text(""),
    );
  }

  Widget _buildTotalPatientS(BuildContext context,
      {required String totalPatientS, required String count}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue, // Background color
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(totalPatientS, style: TextStyle(fontSize: 16)),
          SizedBox(height: 5),
          Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTotalDoctor(BuildContext context,
      {required String totalPatientS, required String count}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 207, 149, 33), // Background color
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(totalPatientS, style: TextStyle(fontSize: 16)),
          SizedBox(height: 5),
          Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildButtonViewDoctors(BuildContext context, String text) {
    return SizedBox(
      width: double.infinity, // Set width to match parent width
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllDoctor()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // Background color
          onPrimary: Colors.white, // Text color
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildButtonViewPatients(BuildContext context, String text) {
    return SizedBox(
      width: double.infinity, // Set width to match parent width
      child: ElevatedButton(
        onPressed: () {
         
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllPatients()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // Background color
          onPrimary: Colors.white, // Text color
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildButtonReviewRegistrations(BuildContext context, String text) {
    return SizedBox(
      width: double.infinity, // Set width to match parent width
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ApproveAdmin()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // Background color
          onPrimary: Colors.white, // Text color
        ),
        child: Text(text),
      ),
    );
  }
}


