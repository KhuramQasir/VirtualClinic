

import 'package:flutter/material.dart';
import 'package:mcqs/Home.dart';

class PatientReport extends StatelessWidget {
  const PatientReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 92),
              _buildReportContainer(context),
              SizedBox(height: 99),
              ElevatedButton(
                onPressed: () {
                  // Perform download action
                },
                child: Text("Download"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  Widget _buildReportContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Report No:", style: TextStyle(fontSize: 16)),
          SizedBox(height: 24),
          Divider(),
          SizedBox(height: 24),
          _buildTextField("Muhammad Atif", "001"),
          SizedBox(height: 23),
          _buildTextField("23.5", "23"),
          SizedBox(height: 23),
          _buildTextField("Male", "Male"),
          SizedBox(height: 23),
          _buildTextField("Dr. Kamal Butt", "Dr. Kamal Butt"),
          SizedBox(height: 23),
          // _buildTextField("Not sleeping properly, Taking drugs.\nWalk daily, Playing games","a"),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(width: 20),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            // navigateToHome;
            // Navigate to home
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Navigate to settings
          },
        ),
      ],
    );
  
  
  }
  // void navigateToHome() {
  //   Navigator.push(
  //     context as BuildContext,
  //     MaterialPageRoute(builder: (context) => HomeScreen()),
  //   );
  // }
}
