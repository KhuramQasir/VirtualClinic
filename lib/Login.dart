import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mcqs/AdminSide/Admindashboard.dart';
import 'package:mcqs/DoctorSide/Doctordashboard.dart';
import 'package:mcqs/GetStart.dart';

import 'package:mcqs/Home.dart';
import 'package:mcqs/PatientHome.dart';
import 'package:mcqs/constants.dart';
import 'signup.dart'; // Import the Signup screen file
import 'package:mcqs/constants.dart'; 
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _result = '';
  bool _isDiseaseFound = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void loginButton() {
  
    loginUser();
  }

 

  void navigateToSignup() {
    // Navigate to Signup screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  Future<void> loginUser() async {
    String Url = "$apiUrl/Userlogin";

    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, String> data = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };

    var response = await http.post(Uri.parse(Url),
        headers: headers, body: json.encode(data));
    var responseBody =await json.decode(response.body);
      var message =await responseBody[0]['message'];
      var userId = responseBody[0]['user_id'];
      var statusCode = responseBody[1];

    if (statusCode == 200) {
     
      if (message == 'Patient login') {
       
        userId=await responseBody[0]['user_id'];
       patientid=userId;


        
         Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GetStart() ),
    );
      } else if (message == "Doctor login") {
       
         Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Doctordashboard()),
    );
      } else if (message == "Admin login") {
       
         Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Admindashboard()),
    );
      } else {
       
      }

      // Now you have the userId and userType, you can use/store them as needed
      print("User ID: $userId");
    
    
    } else {
      // Login failed
      var responseBody = json.decode(response.body);
      var message = responseBody[0]['message'];
      var statusCode = responseBody[1];

      if (statusCode == 401) {
        // Invalid credentials
        print("Invalid credentials: $message");
        // Display error message to user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Failed"),
              content: Text("$message"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // Other errors
        print("Login failed. Error code: ${response.statusCode}");
        // Display generic error message to user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Failed"),
              content: Text("An error occurred while logging in."),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
        child: Center(
        
        child: Padding(
          
          padding: const EdgeInsets.all(19.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Text(
                
                '\n\nLogin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                  border: Border.all(width: 1, color: Colors.black),
                  color: Color(0xFF0EBE7F)
,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(width: 5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(width: 5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: (){
                          loginUser();
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          minimumSize: const Size(270, 40),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: navigateToSignup,
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),),
    );
  
}
}
