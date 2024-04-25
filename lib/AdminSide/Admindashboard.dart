import 'package:flutter/material.dart';
import 'package:mcqs/AdminSide/AdminDoctortableInfo.dart';
import 'package:mcqs/AdminSide/AdminPatinetInfo.dart';
import 'package:mcqs/AdminSide/AdminPatinettableInfo.dart';
import 'package:mcqs/AdminSide/DoctorInfo.dart';

class Admindashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            _buildTotalPatientS(
              context,
              totalPatientS: "Total Doctor’s",
              count: "25",
            ),
            SizedBox(height: 20),
            _buildTotalPatientS(
              context,
              totalPatientS: "Total Patient’s",
              count: "225",
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
              "Patient Matircs",
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
          ],
        ),
      ),
         bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {

Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminPatientInfo())
                              )
                              ;
                              },

),
            IconButton(icon: Icon(Icons.calendar_today), onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminDoctortableInfo())
                              );
            }),
            IconButton(icon: Icon(Icons.lock), onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminPatienttableInfo())
                              );
            }),
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
      trailing: Text("2"),
    );
  }

  Widget _buildTotalPatientS(BuildContext context,
      {required String totalPatientS, required String count}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
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
    return ElevatedButton(
      onPressed: () {
       Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminDoctorInfo())
                              );
      },
      child: Text(text),
    );
  }
   Widget _buildButtonViewPatients(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminPatientInfo())
                              );
      },
      child: Text(text),
    );
  }
   Widget  _buildButtonReviewRegistrations(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.push(
        //                       context,
        //                       MaterialPageRoute(builder: (context) => AdminAproveRegistration())
        //                       );
      },
      child: Text(text),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Admindashboard()));
}
