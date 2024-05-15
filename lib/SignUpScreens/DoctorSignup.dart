import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mcqs/Home.dart';
import 'package:mcqs/Login.dart';
import 'package:mcqs/constants.dart';

class DoctorSignup extends StatefulWidget {
  @override
  _DoctorSignupState createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _expController = TextEditingController();
    TextEditingController _qualificationController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _cnicController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _gender = 'Male'; // Default gender

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> signUpDoctor() async {
    
    try {
    var url = Uri.parse('$apiUrl/DoctorSignUp'); // Replace with your server's IP and port
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "name": _nameController.text,
      "email": _emailController.text,
      "dob": _dobController.text,
      "gender": _gender,
      "password": _passwordController.text,
      "cnic": _cnicController.text,
      "experience": _expController.text, // Assuming experience is stored in city controller
      "qualification": _qualificationController.text, // Assuming qualification is stored in password controller
    });

      var response = await http.post(url, headers: headers, body: body);
      var responseBody = json.decode(response.body);
      var message = responseBody[0]['Message'];
      var statusCode = responseBody[1];

      if (statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text('Sign'),
                  onPressed: () {
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                    {
                       return Login();
                    }
                    )); // Close the dialog
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
              title: Text('Server Error'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  const Text(
                    'Signup Doctor',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 790,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                      ),
                      border: Border.all(width: 1, color: Colors.black),
                      color: const Color(0xFF0EBE7F),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(width: 3),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(width: 3),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _qualificationController,
                            decoration: InputDecoration(
                              hintText: 'Qualification',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(width: 3),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _expController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Experience (years)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(width: 3),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _dobController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  hintText: 'Date of Birth (DOB)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(width: 3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Gender: '),
                              Radio<String>(
                                value: 'Male',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                              ),
                              Text('Male'),
                              Radio<String>(
                                value: 'Female',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                              ),
                              Text('Female'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _cnicController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'CNIC',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(width: 3),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(width: 3),
                              ),
                            ),
                          ),
                            const SizedBox(height: 10),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(width: 3),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              signUpDoctor();
                            },
                            child: Text('Sign Up'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
