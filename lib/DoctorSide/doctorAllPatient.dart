import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/AdminSide/AdminDetailScreen.dart';
import 'package:mcqs/AdminSide/DoctorInfo.dart';
import 'package:mcqs/AdminSide/PatientInfo.dart';
import 'dart:convert';

import 'package:mcqs/constants.dart';



class DoctorAllPatient extends StatefulWidget {
  @override
  _DoctorAllPatientState createState() => _DoctorAllPatientState();
}

class _DoctorAllPatientState extends State<DoctorAllPatient> {
  List<Map<String, dynamic>> Allpatient = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAdminRequests();
  }

  Future<void> fetchAdminRequests() async {
    final url = Uri.parse('$apiUrl/AllPatients');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> requestData = data[0];
        final int statusCode = data[1];

        if (statusCode == 200) {
          if (mounted) {
            setState(() {
              Allpatient = List<Map<String, dynamic>>.from(requestData);
              _isLoading = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          print('Failed to load admin requests');
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        print('Failed to load admin requests');
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Allpatient.isEmpty
              ? Center(child: Text("No Patient requests found"))
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: Allpatient.map((admin) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: _buildItem(context, admin),
                      );
                    }).toList(),
                  ),
                ),
    );
  }

  Widget _buildItem(BuildContext context, Map<String, dynamic> admin) {
    return  
     Card(
        color: Colors.green,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      admin['name'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 
                   
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(onPressed: ()
                     {
           Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PatientInfo(adminId: admin['id'],) ),
    );

                  }, child:Text('Info',style: TextStyle(color: Colors.white) ,))
                 
                ],
              ),
            ],
          ),
        ),
      
    );
  }
}
