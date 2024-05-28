import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mcqs/McqsWithResponse.dart';
import 'package:mcqs/PatientHome.dart';
import 'package:mcqs/constants.dart';

class GetStart extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // double fem = MediaQuery.of(context).size.width / 500; // Adjust according to your design
    // double ffem = MediaQuery.of(context).size.width / 400;
    double fem = 1; // You should define your fem value appropriately
    double ffem = 1; // You should define your ffem value appropriately


 Future<int> getPatientDoctor(String id) async {
    final url = Uri.parse('$apiUrl/getpatientdoctor/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
       Map<String, dynamic> data = jsonDecode(response.body);
       int doctorId = data['Doctor_id'];
     // Assuming data is a Map<String, dynamic>
      


      return doctorId; 
    } else {
      throw Exception('Failed to load patient-doctor data');
    }
  }
  
Future<String> checkDoctor(String patientId) async {
  final url = Uri.parse('$apiUrl/check_doctor');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'patient_id': patientId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty && data[0].containsKey('message')) {
        return data[0]['message'];
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to check doctor');
    }
  } catch (e) {
    throw Exception('Network error: $e');
  }
}


  
  Future<int> storePatientHistory(
  String doctorId,
  String patientId,
  String status,
  int doctorRanking,
  String visitType,
  String visitDate,
) async {
  final String Url = '$apiUrl/storepatienthistory';

  try {
    final response = await http.post(
      Uri.parse(Url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'doctor_id': doctorId,
        'patient_id': patientId,
        'status': status,
        'doctorranking': doctorRanking,
        'visit_type': visitType,
        'visit_date': visitDate,
      }),
    );
print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int phid=data['Patienthistoryid'];
      return phid;
    } else {
      print('Failed to store patient history: ${response.statusCode}');
     return 0;
    }
  } catch (e) {
    print('Error: $e');
    return 0;
  }
}


void _showDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Response'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
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



Future<void> completeQuestionnaire(BuildContext context, String patientId) async {
  final url = Uri.parse('$apiUrl/complete_questionnaire');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'patient_id': patientId,
      }),
    );

    String message;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (responseBody.containsKey('message')) {
        final messageData = responseBody['message'];

        if (messageData is List) {
          bool found = false;

          for (var item in messageData) {
            if (item['patient_id'].toString() == patientId) {
              found = true;
              break;
            }
          }

          if (found) {
            message = 'Request sent successfully. Waiting For Approval';
          } else {
            message = 'Request successful, but no matching patient_id found.';
          }
        } else {
          message = 'Request already in a Queue';
        }
      } else {
        message = 'No data found.';
      }
    } else {
      message = 'Failed to complete the questionnaire. Server responded with status code: ${response.statusCode}';
    }

    _showDialog(context, message);
  } catch (e) {
    _showDialog(context, 'Network error: $e');
  }
}



 Future<void> findDisease(String id) async {
  final url = Uri.parse('$apiUrl/find_disease/$id');
  
  try {
    // Make the HTTP GET request
    final response = await http.get(url);

    // Check if the response is successful
  
      // Decode the JSON response
      Map<String, dynamic>? jsonMap = jsonDecode(response.body);

      // Check if jsonMap is not null
      if (jsonMap != null) {
        // Try to access 'message' and 'patient_id' keys
        String? message = jsonMap['message'];
        int? patientId = jsonMap['patient_id'];

        if (message != null && patientId != null) {
          // Print the message and patient ID
          print('Message: $message');
          print('Patient ID: $patientId');
          pid=patientId;

          // Evaluate the response and print appropriate message
          if (message == "Have Disease") {
           String msg=await  checkDoctor(pid.toString());
             print('Doctor Assign');
                print(msg);
            if(msg=="No"){
                 completeQuestionnaire(context, pid.toString()); // Replace '9' with the actual patient ID you want to test with
            }

            int doctorid=await getPatientDoctor(patientId.toString());
             print('Doctor Id');
               String visitDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

             int patienthistoryid=await storePatientHistory(doctorid.toString(), pid.toString(), 'active', 0, 'Session', visitDate.toString());
             print('Patient History Id');
             print(patienthistoryid);
              phid=patienthistoryid; 
             
              Navigator.push(context, MaterialPageRoute(builder: (context){
                            return PatientHome();
                          }));
            print('Disease found for Patient ID: $patientId');

          } else {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                            return McqsWithResponse();
                          }));
            print('No disease found for Patient ID: $patientId');
          }
        } else {
          print('Error: Response format is incorrect.');
        }
      } else {
        print('Error: Response body is null.');
      }
   
  } catch (e) {
    // Handle the exception here if needed
    print('Error occurred: $e');
  }
}




    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              Container(
                margin: EdgeInsets.fromLTRB(7 * fem, 77 * fem, 0 * fem, 0 * fem),
                child: Text(
                  'Welcome to the Psychologist Test\n',
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.2 * ffem / fem,
                    color: Color(0xff111111),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(39 * fem, 59 * fem, 35 * fem, 178 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(1 * fem, 15 * fem, 0 * fem, 103 * fem),
                      width: 281 * fem,
                      height: 350 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20 * fem),
                        child: Image.asset(
                          'lib/images/Rectangle 83.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                     
                     
                        var res=await findDisease(patientid.toString());
                
                      // if(res==true){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context){
                      //       return PatientHome();
                      //     }));
                      // }else if(res==false){
                      //    Navigator.push(context, MaterialPageRoute(builder: (context){
                      //       return McqsWithResponse();
                      //     }));
                      // }



                       
                      },
                      child: Container(
                        width: 190,
                        height: 40 * fem,
                        decoration: BoxDecoration(
                          color: Color(0xff0ebe7f),
                          borderRadius: BorderRadius.circular(20 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000),
                              offset: Offset(0 * fem, 0 * fem),
                              blurRadius: 3.5 * fem,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 19.2903232574 * ffem,
                              fontWeight: FontWeight.w800,
                              height: 1.2 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

