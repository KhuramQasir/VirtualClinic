import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mcqs/Home.dart';
import 'package:mcqs/Login.dart';

class PatientSignup extends StatefulWidget {
  @override
  _PatientSignupState createState() => _PatientSignupState();
}

class _PatientSignupState extends State<PatientSignup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _cnicController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _gender = 'Male'; // Default gender

  void signupButton() {
    String name = _nameController.text;
    String email = _emailController.text;
    String city = _cityController.text;
    String dob = _dobController.text;
    String cnic = _cnicController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    print(name);
    print(email);
    print(city);
    print(dob);
    print(_gender);
    print(cnic);
    print(password);
    print(confirmPassword);

    // Navigate to MCQs screen after successful signup
    
  }
Future<void> signUpPatient() async {
   try {
  var url = Uri.parse('http://192.168.100.22:5000/PatientSignUp'); // Replace with your server's IP and port
  var headers = {'Content-Type': 'application/json'};
  var body = json.encode({
    "name":  _nameController.text,
    "email": _emailController.text,
    "dob": _dobController.text,
    "city": _cityController.text,
    "gender": _gender,
    "password": _passwordController.text,
    "cnic": _cnicController.text
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
                    ));
                    // Do something when OK is pressed
                     // Close the dialog
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
                    // Do something when OK is pressed
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
    }
  } catch (e) {
    print('Error: $e'); // Catch any exceptions
  }
}
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
                    'Signup Patient',
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
                    height: 720,
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
                            controller: _cityController,
                            decoration: InputDecoration(
                              hintText: 'City',
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
                              signUpPatient();
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
