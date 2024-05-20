import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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



void main() {
  runApp(MaterialApp(
    home: GetStart(),
  ));
}
