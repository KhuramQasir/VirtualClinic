import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/Super%20Doctor/patientsListScreen.dart' as patientsScreen;
import 'package:mcqs/constants.dart' as constants;

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({Key? key}) : super(key: key);

  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  late Future<List<Doctor>> futureDoctors;

  @override
  void initState() {
    super.initState();
    futureDoctors = fetchDoctors();
  }

  Future<List<Doctor>> fetchDoctors() async {
    final response = await http.get(Uri.parse('${constants.apiUrl}/get_require_ranking_doctors'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> doctorsData = responseData[0]['data']['doctors'];
      return doctorsData.map((doctor) => Doctor.fromJson(doctor)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors List'),
      ),
      body: FutureBuilder<List<Doctor>>(
        future: futureDoctors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No doctors found'));
          } else {
            final doctors = snapshot.data!;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green,
                  child: ListTile(
                    title: Text(
                      doctors[index].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      'Experience: ${doctors[index].experienceYears} years',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return patientsScreen.PatientsListPage(doctorId: doctors[index].id);
                          }),
                        );
                      },
                      icon: Icon(Icons.next_plan),
                      color: Colors.white,
                    ),
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

class Doctor {
  final String name;
  final String experienceYears;
  final int id;

  Doctor({
    required this.name,
    required this.experienceYears,
    required this.id
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      experienceYears: json['experience_years'],
      id: json['id'],
    );
  }
}
