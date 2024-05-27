import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/DoctorSide/Doctordashboard.dart';
import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    fetchPrescriptions();
  }

  Future<void> fetchPrescriptions() async {
  final response = await http.get(Uri.parse('$apiUrl/get_all_prescriptions'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<String> prescriptions = List<String>.from(data[0]['prescriptions']);
    setState(() {
      dropdownItemList = prescriptions.toSet().toList(); // Remove duplicates
    });
  } else {
    throw Exception('Failed to load prescriptions');
  }
}


Future<void> setPrescriptions() async {
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
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Doctordashboard()),
                  );
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
          content: Text('Failed to set prescriptions'),
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
            Padding(
              padding: EdgeInsets.only(left: 126),
              child: Text(
                "Prescription",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 19),
            Center(child: _buildDropDown(context)),
            SizedBox(height: 26),
            Center(child: _buildAdd(context)),
            SizedBox(height: 33),
            Center(
                child: Container(
                    height: 300,
                    child: SingleChildScrollView(child: _buildView(context)))),
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
    return SizedBox(
      width: 100, // Increase the width as needed
      child: ElevatedButton(
        onPressed: () {
          if (selectedPrescription != null) {
            setState(() {
              addedPrescriptions.add(selectedPrescription!);
            });
          }
        },
        child: Text("Add", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
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
      width: 100, // Increase the width as needed
      child: ElevatedButton(
        onPressed: () {
          setPrescriptions();
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
