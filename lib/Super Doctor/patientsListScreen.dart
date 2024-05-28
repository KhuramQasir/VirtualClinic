import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/Super%20Doctor/prescriptionListPage.dart';
import 'package:mcqs/constants.dart';

// Replace with your actual API URL

class PatientsListPage extends StatefulWidget {
  final int doctorId;

  const PatientsListPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  _PatientsListPageState createState() => _PatientsListPageState();
}

class _PatientsListPageState extends State<PatientsListPage> {
  late Future<List<Patient>> futurePatients;

  @override
  void initState() {
    super.initState();
    futurePatients = fetchPatients(widget.doctorId);
    print('Doctor Id');
    print(widget.doctorId);

  }

  Future<List<Patient>> fetchPatients(int doctorId) async {
    final response = await http.get(Uri.parse('$apiUrl/get_require_ranking_patients/$doctorId'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> patientsData = responseData[0]['data']['patients'];
      return patientsData.map((patient) => Patient.fromJson(patient)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
      ),
      body: FutureBuilder<List<Patient>>(
        future: futurePatients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No patients found'));
          } else {
            final patients = snapshot.data!;
            return ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green,
                  child: ListTile(
                    title: Text(patients[index].name,   style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),
                    subtitle: Text('City: ${patients[index].city}',  style: TextStyle(color: Colors.white),),
                    trailing: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return PrescriptionListPage(patientId: patients[index].id,did: widget.doctorId,);
                      }));
                    }, child: Text('Info',style: TextStyle(color: Colors.white),),)
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Patient {
  final String name;
  final String city;
  final String cnic;
  final String dob;
  final String gender;
  final int id;
  final int userId;

  Patient({
    required this.name,
    required this.city,
    required this.cnic,
    required this.dob,
    required this.gender,
    required this.id,
    required this.userId,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      city: json['city'],
      cnic: json['cnic'],
      dob: json['dob'],
      gender: json['gender'],
      id: json['id'],
      userId: json['user_id'],
    );
  }
}
