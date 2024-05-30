import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mcqs/DoctorSide/patientRecord.dart';
import 'package:mcqs/constants.dart';

class SelectQuestion extends StatefulWidget {
  final List<String> PQuestion;

  SelectQuestion({
    required this.PQuestion,
  });

  @override
  _SelectQuestionState createState() => _SelectQuestionState();
}

class _SelectQuestionState extends State<SelectQuestion> {
  List<dynamic> patientAppointments = [];

  @override
  void initState() {
    super.initState();
    fetchDoctorRoster(doctor_id_d); // Assuming doctor ID is 1 for this example
  }

  Future<void> fetchDoctorRoster(int doctorId) async {
    final response = await http.get(Uri.parse('$apiUrl/DoctorRoster/$doctorId'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        patientAppointments = responseData[0]['data']['Patients'];
      });
    } else {
      throw Exception('Failed to load doctor roster');
    }
  }

  List<dynamic> getCurrentAppointments() {
    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    return patientAppointments.where((appointment) {
      final startTime = TimeOfDay(
        hour: int.parse(appointment['start_time'].split(':')[0]),
        minute: int.parse(appointment['start_time'].split(':')[1]),
      );
      final endTime = TimeOfDay(
        hour: int.parse(appointment['end_time'].split(':')[0]),
        minute: int.parse(appointment['end_time'].split(':')[1]),
      );

      return (currentTime.hour > startTime.hour || (currentTime.hour == startTime.hour && currentTime.minute >= startTime.minute)) &&
             (currentTime.hour < endTime.hour || (currentTime.hour == endTime.hour && currentTime.minute <= endTime.minute));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  "Remaining time 3:49",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red[800],
                  ),
                ),
                SizedBox(height: 6),
                Divider(
                  color: Colors.black.withOpacity(0.86),
                  indent: 52,
                  endIndent: 61,
                ),
                SizedBox(height: 7),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(),
                  ),
                  width: 350,
                  height: 400,
                  child: ListView.builder(
                    itemCount: widget.PQuestion.length,
                    itemBuilder: (context, index) {
                      final question = widget.PQuestion[index];

                      return ListTile(
                        leading: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: Text(question),
                      );
                    },
                  ),
                ),
                SizedBox(height: 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Start"),
                    ),
                    SizedBox(width: 31),
                    ElevatedButton(
                      onPressed: () async{
                        final currentAppointments =await getCurrentAppointments();
                        if (currentAppointments.isNotEmpty) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            final appointment = currentAppointments.first;
                            return PatientRcord();
                          }));
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       title: Text('Current Appointments'),
                          //       content: Column(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: currentAppointments.map((appointment) {
                          //           return Text(
                          //             'Appointment for patient ID: ${appointment['Patient_id']}\nPatient Name: ${appointment['patientName']}',
                          //             style: TextStyle(
                          //               fontSize: 18,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           );
                          //         }).toList(),
                          //       ),
                          //       actions: [
                          //         ElevatedButton(
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //           child: Text('OK'),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('No Current Appointments'),
                                content: Text(
                                  'There are no appointments for the current time.',
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text("End"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.only(left: 11.0),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
