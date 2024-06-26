import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';


class PatientReport extends StatefulWidget {
  const PatientReport({Key? key}) : super(key: key);


  @override
  _PatientReportState createState() => _PatientReportState();
}

class _PatientReportState extends State<PatientReport> {
  Future<Map<String, dynamic>>? _reportFuture;

  @override
  void initState() {
    super.initState();
    _reportFuture = fetchPatientReport(pid);
  }

  Future<Map<String, dynamic>> fetchPatientReport(int id) async {
    final String Url = '$apiUrl/PatientReport/$id'; // Replace with your actual API URL

    try {
      final response = await http.get(Uri.parse(Url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty && data[0].containsKey('message')) {
          return data[0]['message'];
        } else {
          print('Invalid data format');
          return {};
        }
      } else {
        print('Failed to load patient report: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

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
          child: FutureBuilder<Map<String, dynamic>>(
            future: _reportFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No report found'));
              } else {
                final report = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 92),
                    _buildReportContainer(context, report),
                    // SizedBox(height: 99),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Perform download action
                    //   },
                    //   child: Text("Download"),
                    // ),
                  ],
                );
              }
            },
          ),
        ),
      ),
     
    );
  }

  Widget _buildReportContainer(BuildContext context, Map<String, dynamic> report) {
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
          _buildTextField("Report No:", report['ReportNo'].toString()),
          SizedBox(height: 24),
          Divider(),
          SizedBox(height: 24),
          _buildTextField("Patient Name:", report['PatientName']),
          SizedBox(height: 23),
          _buildTextField("Age:", report['Age'].toString()),
          SizedBox(height: 23),
          _buildTextField("Gender:", report['Gender']),
          SizedBox(height: 23),
          _buildTextField("Doctor Name:", report['DoctorName']),
          SizedBox(height: 23),
          SingleChildScrollView (  scrollDirection: Axis.horizontal,
            child: _buildTextField("Diagnostic:", report['Diagnostic'])),
          SizedBox(height: 23),
           SingleChildScrollView (  scrollDirection: Axis.horizontal,
            child:
          _buildTextField("Prescriptions:", report['Prescriptions'])),
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

 
}
