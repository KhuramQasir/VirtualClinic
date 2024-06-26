import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mcqs/constants.dart'; // Replace with your actual constants file

class ApprovePatient extends StatefulWidget {
  const ApprovePatient({Key? key}) : super(key: key);

  @override
  _ApprovePatientState createState() => _ApprovePatientState();
}

class _ApprovePatientState extends State<ApprovePatient> {
  late Future<List<Request>> futureRequests;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    futureRequests = fetchRequests(doctor_id_d);  // Replace with actual doctor_id if needed

    // Start periodic fetching every 10 seconds
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      if (mounted) { // Check if the widget is still mounted
      
        fetchRequests(doctor_id_d); // Refresh requests every 10 seconds
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<List<Request>> fetchRequests(int doctorId) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/doctor_requests'),  
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'doctor_id': doctorId}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => Request.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load requests');
      }
    } catch (e) {
      print('Error fetching requests: $e');
      return []; // Return empty list in case of error
    }
  }

  Future<void> assignDoctorToPatient(int patientId, int doctorId) async {
    final url = Uri.parse('$apiUrl/doctor_assign_to_patient');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'patient_id': patientId,
      'doctor_id': doctorId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Doctor assigned to patient successfully');
        // No need to clear and fetch again, as the periodic timer will handle updates
        final responseData = jsonDecode(response.body);
        print(responseData);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Doctor assigned to patient successfully'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to assign doctor to patient. Status code: ${response.statusCode}'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> postPatientSchedule(List<Map<String, String>> schedules) async {
    final Uri url = Uri.parse('$apiUrl/PatientSchedule');

    for (var schedule in schedules) {
      try {
        final http.Response response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(schedule), // Send each schedule map
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          if (jsonResponse.containsKey('message')) {
            print('Schedule added successfully: ${jsonResponse['message']}');
          } else {
            throw Exception('Unexpected response format');
          }
        } else {
          throw Exception('Failed to post patient schedule: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to post patient schedule: $e');
      }
    }
  }

  List<Map<String, String>> getAppointmentJson(int pid) {
    // Get the current time
    DateTime now = DateTime.now();
    // Format the current time as HH:mm:ss
    String startTime = DateFormat('HH:mm:ss').format(now);

    // Calculate end time (30 minutes later)
    DateTime endTime = now.add(Duration(minutes: 30));
    // Format the end time as HH:mm:ss
    String endTimeFormatted = DateFormat('HH:mm:ss').format(endTime);

    // Format today's date as yyyy-MM-dd
    String date = DateFormat('yyyy-MM-dd').format(now);

    // Create a list containing appointment details as a map
    return [
      {
        "starttime": startTime,
        "endtime": endTimeFormatted,
        "patient_id": pid.toString(),
        "date": date
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Requests'),
      ),
      body: FutureBuilder<List<Request>>(
        future: futureRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No requests found'));
          } else {
            return RefreshIndicator(
              onRefresh: () => fetchRequests(doctor_id_d),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final request = snapshot.data![index];
                  return ListTile(
                    title: Text(request.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Disease: ${request.disease}'),
                        Text('Date: ${request.date}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () async {
                            await assignDoctorToPatient(request.id, doctor_id_d);
                            var res = getAppointmentJson(int.parse(request.id.toString()));
                            await postPatientSchedule(res); // Pass the list directly
                            print('Appointment scheduled.');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Handle reject action
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class Request {
  final String date;
  final String disease;
  final int id;
  final String name;

  Request({
    required this.date,
    required this.disease,
    required this.id,
    required this.name,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      date: json['date'],
      disease: json['disease'],
      id: json['id'],
      name: json['name'],
    );
  }
}
