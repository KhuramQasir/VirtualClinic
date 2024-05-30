import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/DoctorSide/DoctorPrescrition.dart';
import 'package:mcqs/DoctorSide/buttonsScreen.dart';
import 'package:mcqs/DoctorSide/patientQuestionResponse.dart';
import 'package:mcqs/Super%20Doctor/DoctorRating.dart';
import 'package:mcqs/Super%20Doctor/buttonsScreen.dart';
import 'package:mcqs/Super%20Doctor/questionResponsePage.dart';
import 'package:mcqs/constants.dart';

class PatientRcord extends StatefulWidget {
  const PatientRcord({Key? key}) : super(key: key);




  @override
  _PatientRcordState createState() => _PatientRcordState();
}

class _PatientRcordState extends State<PatientRcord> {
  late Future<List<Prescription>> futurePrescriptions;

  @override
  void initState() {
    super.initState();
    futurePrescriptions = fetchPrescriptions(patient_id_for_doctor);
  }

  Future<List<Prescription>> fetchPrescriptions(int patientId) async {
    final response = await http.get(Uri.parse('$apiUrl/getpatientprescriptionlist/$patientId'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> prescriptionsData = responseData[0]['data'];
      return prescriptionsData.map((prescription) => Prescription.fromJson(prescription)).toList();
    } else {
      throw Exception('Failed to load prescriptions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
              
                     ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      onPressed: () {
                       Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionResponsePage(patientId: patient_id_for_doctor,)),
                  );
                },child: Text(
                        "Questionnaire Record",
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                     ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      onPressed: () {
                       Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorPrescription())
                  );
                },
                     
                      child: Text(
                        "Set Prescription",
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),


                 
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Prescription>>(
              future: futurePrescriptions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: No Data For This'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No prescriptions found'));
                } else {
                  final prescriptions = snapshot.data!;
                  return ListView.builder(
                    itemCount: prescriptions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.green,
                        child: ListTile(
                          title: Text(
                            prescriptions[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            'Date: ${prescriptions[index].date}\nPrescriptions: ${prescriptions[index].prescriptions}',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return twoButtonsScreenDoctor(date: prescriptions[index].date,);
                            }));
                          }, icon: Icon(Icons.view_agenda,color: Colors.white)),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Prescription {
  final String date;
  final String name;
  final int patientId;
  final String prescriptions;

  Prescription({
    required this.date,
    required this.name,
    required this.patientId,
    required this.prescriptions,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      date: json['date'],
      name: json['name'],
      patientId: json['patient_id'],
      prescriptions: json['prescriptions'],
    );
  }
}
