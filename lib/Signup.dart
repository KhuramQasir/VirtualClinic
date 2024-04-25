import 'package:flutter/material.dart';
import 'package:mcqs/Home.dart';
 // Assuming MCQs is the screen after successful signup

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void signupButton() {
    String name = _nameController.text;
    String email = _emailController.text;
    String dob = _dobController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String gender = ''; // You can add logic to get gender from Radio buttons or Dropdown

    print(name);
    print(email);
    print(dob);
    print(gender);
    print(password);
    print(confirmPassword);

    // Navigate to MCQs screen after successful signup
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Signup',
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
                  height: 480,
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
                        const SizedBox(height: 10),
                        // Add Gender selection widget here (e.g., Radio buttons or Dropdown)
                      
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
                          onPressed: signupButton,
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
    );
  }
}
