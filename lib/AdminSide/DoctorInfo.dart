import 'package:flutter/material.dart';
import 'package:mcqs/AdminSide/AdminDoctortableInfo.dart';
import 'package:mcqs/AdminSide/AdminPatinetInfo.dart';
import 'package:mcqs/AdminSide/AdminPatinettableInfo.dart';

class AdminDoctorInfo extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Image.asset('assets/images/untitled1_recovered.png'), // Your appbar title image
        centerTitle: true,
        elevation: 0, // No elevation
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildAdminOfClinic(),
            SizedBox(height: 13),
            Text(
              "Doctors",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red[800]),
            ),
            SizedBox(height: 14),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 21),
            _buildPatientCard("Tooba Jamil", "Schizophrenia"),
            SizedBox(height: 27),
            _buildPatientCard("Dr. Hassan", "Bipolar Disorder"),
            SizedBox(height: 27),
            _buildPatientCard("Emily John", "Anxiety Disorder"),
            SizedBox(height: 27),
            _buildPatientCard("Olivia Smith", "Eating Disorder"),
            SizedBox(height: 27),
            _buildPatientCard("Ava Williams", "Schizophrenia"),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "More",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            SizedBox(height: 18),
            Divider(color: Colors.black.withOpacity(0.29)),
            SizedBox(height: 8),
            Divider(color: Colors.black),
          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {

Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminPatientInfo())
                              )
                              ;
                              },

),
            IconButton(icon: Icon(Icons.calendar_today), onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminDoctortableInfo())
                              );
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

  Widget _buildAdminOfClinic() {
    return ListTile(
      title: Text("2", style: TextStyle(fontSize: 16)),
      leading: CircleAvatar(child: Icon(Icons.person)),
      trailing: Text("admin of clinic", style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildPatientCard(String name, String condition) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(child: Icon(Icons.person)),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(condition, style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          Text("info", style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: AdminDoctorInfo()));
}
