import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mcqs/DoctorSide/DoctorAppointment.dart';
import 'package:mcqs/DoctorSide/Doctordashboard.dart';
import 'package:mcqs/Super%20Doctor/DoctorRating.dart';
import 'package:mcqs/Super%20Doctor/doctorsList.dart';
import 'package:mcqs/Super%20Doctor/home.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Image.asset('lib/images/logo.jpg')),
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
