import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';


class PatientSchedulesScreen extends StatefulWidget {
  const PatientSchedulesScreen({Key? key}) : super(key: key);


  @override
  _PatientSchedulesScreenState createState() => _PatientSchedulesScreenState();
}

class _PatientSchedulesScreenState extends State<PatientSchedulesScreen> {
  Future<List<Map<String, dynamic>>>? _schedulesFuture;

  @override
  void initState() {
    super.initState();
    _schedulesFuture = getPatientSchedules(pid);
  }

  Future<List<Map<String, dynamic>>> getPatientSchedules(int id) async {
    final String api = '$apiUrl/getpatientschedules/$id'; // Replace with your actual API URL

    try {
      final response = await http.get(Uri.parse(api));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('data')) {
          return List<Map<String, dynamic>>.from(data['data']);
        } else {
          print('No data field in response');
          return [];
        }
      } else {
        print('Failed to load patient schedules: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Schedules'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _schedulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No schedules found'));
          } else {
            final schedules = snapshot.data!;
            return ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                return Card(
                  child: ListTile(
                    title: Text('Date: ${schedule['date']}'),
                    trailing: Text(
                      'Start Time: ${schedule['start_time']}\nEnd Time: ${schedule['end_time']}',
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
