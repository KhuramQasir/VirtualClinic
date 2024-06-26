import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mcqs/Login.dart';
import 'package:mcqs/McqsWithResponse.dart';
import 'package:mcqs/PatientHome.dart';
import 'package:mcqs/constants.dart';
import 'package:mcqs/patienthomeNavigation.dart';






// class ApiService {

//   // Function to complete the questionnaire
//   static Future<Map<String, dynamic>> completeQuestionnaire(String patientId) async {
//     final url = Uri.parse('$apiUrl/complete_questionnaire');

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'patient_id': patientId,
//         }),
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         // Handle non-200 responses
//         return {
//           'error': 'Error ${response.statusCode}: ${response.body}'
//         };
//       }
//     } catch (e) {
//       // Handle any errors that occur during the request
//       return {
//         'error': 'Failed to connect to the server: $e'
//       };
//     }
//   }
// }













class GetStart extends StatelessWidget {
  const GetStart({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    // double fem = MediaQuery.of(context).size.width / 500; // Adjust according to your design
    // double ffem = MediaQuery.of(context).size.width / 400;
    double fem = 1; // You should define your fem value appropriately
    double ffem = 1; // You should define your ffem value appropriately
      String _resultMessage = '';


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
// void _completeQuestionnaire() async {
    
//     // Call the API service
//     var result = await ApiService.completeQuestionnaire(patientid.toString());

//       if (result.containsKey('message')) {
//         _resultMessage = result['message'];
//       } else if (result.containsKey('error')) {
//         _resultMessage = result['error'];
//       } else {
//         _resultMessage = 'Unknown error occurred';
//       }

//   }



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
            //  var result = await ApiService.completeQuestionnaire(patientid.toString());
                completeQuestionnaire(context, pid.toString()); // Replace '9' with the actual patient ID you want to test with
              

                  

            }

            int doctorid=await getPatientDoctor(patientId.toString());
             print('Doctor Id');
               String visitDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

             int patienthistoryid=await storePatientHistory(doctorid.toString(), pid.toString(), 'active', 0, 'Session', visitDate.toString());
             int patienthistoryidforvideo=await storePatientHistory(doctorid.toString(), pid.toString(), 'active', 0, 'videoCall', visitDate.toString());
          
             print('Patient History Id for Session');
             print(patienthistoryid);
              phid=patienthistoryid; 
             print('Patient History Id for Video');
             print(patienthistoryidforvideo);
              Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => PatientHomeNavigation()),
                      (Route<dynamic> route) => false
                    );
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
Future<Map<String, dynamic>> doctorLogout(String baseUrl, String id) async {
  final url = '$baseUrl/logout/$id';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> responseBody = jsonDecode(response.body);

      // Check if the structure matches the expected format
      if (responseBody.length == 2 && responseBody[1] == 200) {
        return {
          'message': responseBody[0]['message'],
          'status': responseBody[1]
        };
      } else {
        return {
          'error': 'Unexpected response format',
          'status': response.statusCode
        };
      }
    } else {
      return {
        'error': 'Failed to logout. Server returned status: ${response.statusCode}',
        'status': response.statusCode
      };
    }
  } catch (e) {
    return {
      'error': 'An error occurred: $e',
      'status': 500
    };
  }
}

 void logoutpatient(String id) async {
    var result = await doctorLogout('$apiUrl', id);

    if (result.containsKey('message') && result['status'] == 200) {
      print('Logout successful: ${result['message']}');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text(result['message']),
          actions: [
            TextButton(
            onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false
                    );
                  },

              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print('Logout failed: ${result['error']}');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(result['error']),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }



    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 100,),
            Center(child: Image.asset('lib/images/logo.jpg')),
            SizedBox(width: 36,),
            IconButton(onPressed: (){
               logoutpatient(patientid.toString());
            }, icon: Icon(Icons.logout,color: Colors.green,))
          ],
        ),
      ),  body: SingleChildScrollView(
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20), // Adjusted for less space
          child: Text(
            'Welcome to the Psychologist Test\n',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: Color(0xff111111),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Adjusted for less space
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20), // Adjusted for less space
                width: 281,
                height: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'lib/images/Rectangle 83.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var res = await findDisease(patientid.toString());
                  // Handle the response accordingly
                },
                child: Container(
                  width: 190,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff0ebe7f),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000),
                        offset: Offset(0, 0),
                        blurRadius: 3.5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 19.3,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
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

