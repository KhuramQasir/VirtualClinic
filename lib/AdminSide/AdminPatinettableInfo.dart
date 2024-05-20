import 'package:flutter/material.dart';
import 'package:mcqs/AdminSide/AdminDetailScreen.dart';
import 'package:mcqs/AdminSide/AdminPatinetInfo.dart';

class AdminPatienttableInfo extends StatelessWidget {
  const AdminPatienttableInfo ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patinet Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildTextField(context, "Name:", TextInputType.text),
            SizedBox(height: 10),
            _buildTextField(context, "Date of birth:", TextInputType.datetime),
            SizedBox(height: 10),
            _buildTextField(context, "Email", TextInputType.emailAddress),
            SizedBox(height: 10),
            _buildTextField(context, "CNIC", TextInputType.text),
            SizedBox(height: 10),
            Text(
              "Gender",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                _buildGenderOption(context, "Male"),
                SizedBox(width: 10),
                _buildGenderOption(context, "Female"),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Qualification",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Column(
              children: [
                _buildDropDown(context, "Matric"),
                SizedBox(width: 10),
                _buildTextField(context, "School/College/University", TextInputType.text),
                SizedBox(width: 10),
                _buildTextField(context, "Year", TextInputType.number),
              ],
            ),
            SizedBox(height: 10),
            _buildTextField(context, "Password:", TextInputType.visiblePassword, isPassword: true),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(context, "Delete", Colors.red),
                SizedBox(width: 10),
                _buildButton(context, "Save", Colors.blue),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {

// Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => AdminPatientInfo())
//                               )
//                               ;
                              },

),
            IconButton(icon: Icon(Icons.calendar_today), onPressed: () {
              // Navigator.push(
              //                 context,
              //                 MaterialPageRoute(builder: (context) => AdminDoctortableInfo())
              //                 );
            }),
            IconButton(icon: Icon(Icons.lock), onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminPatienttableInfo())
                              );
            }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String hintText, TextInputType keyboardType, {bool isPassword = false}) {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40), // Add constraints
      child: TextFormField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Widget _buildGenderOption(BuildContext context, String label) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(width: 5),
        Text(label),
      ],
    );
  }

  Widget _buildDropDown(BuildContext context, String initialValue) {
    return DropdownButton<String>(
      value: initialValue,
      onChanged: (String? newValue) {},
      items: <String>['Matric', 'Inter', 'Bachelor', 'Master'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildButton(BuildContext context, String label, Color color) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
      style: ElevatedButton.styleFrom(primary: color),
    );
  }
}
