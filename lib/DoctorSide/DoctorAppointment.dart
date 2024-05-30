import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';


class DoctorAppointment extends StatelessWidget {
  final int doctorId = doctor_id_d; // Example doctor ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Roster'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDoctorRoster(doctorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            if (snapshot.data!.containsKey('message')) {
              return Center(child: Text(snapshot.data!['message']));
            } else if (snapshot.data!.containsKey('Patients')) {
              List<dynamic> patients = snapshot.data!['Patients'];
              return ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  var patient = patients[index];
                  return Card(
                    color: Colors.green,
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.white),
                      title: Text(patient['patientName']),
                      subtitle: Text('Disease: ${patient['disease']}', style: TextStyle(color: Colors.white)),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Start: ${patient['start_time']}', style: TextStyle(color: Colors.white)),
                          Text('End: ${patient['end_time']}', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data found'));
            }
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchDoctorRoster(int id) async {
    final String api = '$apiUrl/DoctorRoster/$id'; // Replace with your actual API URL

    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse[0].containsKey('data')) {
        return jsonResponse[0]['data'];
      } else if (jsonResponse[0].containsKey('message')) {
        return {'message': jsonResponse[0]['message']};
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load doctor roster');
    }
  }
}
