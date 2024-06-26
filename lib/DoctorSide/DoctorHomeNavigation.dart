import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mcqs/DoctorSide/DoctorAppointment.dart';
import 'package:mcqs/DoctorSide/Doctordashboard.dart';
import 'package:mcqs/Login.dart';
import 'package:mcqs/Super%20Doctor/DoctorRating.dart';
import 'package:mcqs/Super%20Doctor/doctorsList.dart';
import 'package:mcqs/Super%20Doctor/home.dart';
import 'package:mcqs/constants.dart';

/// Flutter code sample for [BottomNavigationBar].

class DoctorHomeNavigation extends StatefulWidget {
  const DoctorHomeNavigation({Key? key}) : super(key: key);

  @override
  State<DoctorHomeNavigation> createState() => _DoctorHomeNavigationState();
}

class _DoctorHomeNavigationState extends State<DoctorHomeNavigation> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Doctordashboard()
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

Future<Map<String, dynamic>> doctorLogout(String baseUrl, String id) async {
  final url = '$baseUrl/doctorlogout/$id';

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

 void logoutDoctor(String id) async {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 50,),
            Center(child: Image.asset('lib/images/logo.jpg')),
            SizedBox(width: 30,),
            IconButton(onPressed: (){
               logoutDoctor(doctor_id_d.toString());
            }, icon: Icon(Icons.logout,color: Colors.green,))
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
       backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: 'Appointments',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mobile_friendly),
            label: 'Sessions',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Video Call',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_sharp),
            label: 'Patients Record',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
