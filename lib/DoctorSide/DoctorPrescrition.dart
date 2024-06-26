import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

// Replace with actual imports from your project
import 'package:mcqs/DoctorSide/DoctorHomeNavigation.dart';
import 'package:mcqs/constants.dart';

class DoctorPrescription extends StatefulWidget {
  DoctorPrescription({Key? key}) : super(key: key);

  @override
  _DoctorPrescriptionState createState() => _DoctorPrescriptionState();
}

class _DoctorPrescriptionState extends State<DoctorPrescription> {
  TextEditingController prescribedController = TextEditingController();
  List<String> dropdownItemList = [];
  String? selectedPrescription;
  List<String> addedPrescriptions = [];
  int patientId = patient_id_for_doctor;

  bool isChecked = false;
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    fetchPrescriptions();
  }

  Future<void> fetchPrescriptions() async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl/get_all_prescriptions'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<String> prescriptions =
            List<String>.from(data[0]['prescriptions']);
        setState(() {
          dropdownItemList = prescriptions.toSet().toList();
        });
      } else {
        throw Exception('Failed to load prescriptions');
      }
    } catch (e) {
      print('Error fetching prescriptions: $e');
    }
  }

  List<Map<String, String>> getAppointmentJson(int pid, DateTime now) {
    String startTime = DateFormat('HH:mm:ss').format(now);
    DateTime endTime = now.add(Duration(minutes: 30));
    String endTimeFormatted = DateFormat('HH:mm:ss').format(endTime);
    String date = DateFormat('yyyy-MM-dd').format(now);

    return [
      {
        "starttime": startTime,
        "endtime": endTimeFormatted,
        "patient_id": pid.toString(),
        "date": date
      }
    ];
  }

  Future<void> setPrescriptions() async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/set_prescription/$patientId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'prescriptions': addedPrescriptions}),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Prescriptions set successfully'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return DoctorHomeNavigation();
                        }));
                    },
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Failed to set prescriptions');
      }
    } catch (e) {
      print('Error setting prescriptions: $e');
    }
  }

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? now),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 19),
            Divider(
              color: Color.fromARGB(255, 34, 195, 117).withOpacity(0.86),
              indent: 52,
              endIndent: 61,
            ),
            SizedBox(height: 26),
            InkWell(
              onTap: () {
                _pickDateTime();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 126),
                child: Text(
                  "Prescription",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 19),
            Center(child: _buildDropDown(context)),
            SizedBox(height: 26),
            Center(child: _buildAdd(context)),
            if (selectedDateTime != null) ...[
              SizedBox(height: 16),
              Center(
                child: Text(
                  "Selected DateTime: ${selectedDateTime.toString()}",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ],
            SizedBox(height: 33),
            Center(
              child: Container(
                height: 300,
                child: SingleChildScrollView(child: _buildView(context)),
              ),
            ),
            SizedBox(height: 54),
            Center(child: _buildSet(context)),
            SizedBox(height: 56),
            Divider(
              color: Colors.black.withOpacity(0.86),
              indent: 22,
              endIndent: 20,
            ),
            SizedBox(height: 52),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 63, vertical: 10),
      child: DropdownButton<String>(
        hint: Text("Select Prescription"),
        value: selectedPrescription,
        items: dropdownItemList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedPrescription = value;
          });
        },
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        isExpanded: true,
      ),
    );
  }

  Widget _buildAdd(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 63),
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _pickDateTime();
                  },
                  child: Text(
                    "Schedule Next appointment",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                addedPrescriptions.add(selectedPrescription!);
                isChecked = false;
                selectedPrescription = null;
              });
            },
            child: Text("Add", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
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
        print('Failed to post patient schedule: $e');
      }
    }
  }

  Widget _buildView(BuildContext context) {
    return Container(
      width: 386,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 23),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: addedPrescriptions.map((prescription) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                SizedBox(width: 7),
                Text(prescription),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSet(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: () async {
          if (isChecked) {
            setPrescriptions();
            var res = getAppointmentJson(patientId, selectedDateTime!);
            print(res);
            await postPatientSchedule(res); // Pass the list directly
          } else {
            setPrescriptions();
          }
        },
        child: Text("Set", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
