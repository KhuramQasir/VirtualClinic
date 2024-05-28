import 'package:flutter/material.dart';
import 'package:mcqs/GetStart.dart';
import 'package:mcqs/Super%20Doctor/DoctorRating.dart';
import 'package:mcqs/Super%20Doctor/doctorsList.dart';
import 'package:mcqs/Super%20Doctor/home.dart';

/// Flutter code sample for [BottomNavigationBar].

class PatientNavigationBar extends StatefulWidget {
  const PatientNavigationBar({Key? key}) : super(key: key);

  @override
  State<PatientNavigationBar> createState() => _PatientNavigationBarState();
}

class _PatientNavigationBarState extends State<PatientNavigationBar> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    GetStart(),
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
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
