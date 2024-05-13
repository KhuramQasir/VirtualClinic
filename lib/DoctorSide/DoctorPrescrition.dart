import 'package:flutter/material.dart';

class DoctorPrescrition extends StatelessWidget {
  TextEditingController prescribedController = TextEditingController();
  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 19),
            Divider(color: Colors.black.withOpacity(0.86), indent: 52, endIndent: 61),
            SizedBox(height: 26),
            Padding(
              padding: EdgeInsets.only(left: 146),
              child: Text("Prescription", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 51),
            _buildPrescriptionTextField(),
            SizedBox(height: 19),
            _buildDropDown(),
            SizedBox(height: 26),
            _buildButton("Add"),
            SizedBox(height: 33),
            _buildButton("View"),
            SizedBox(height: 54),
            _buildButton("Set"),
            SizedBox(height: 56),
            Divider(color: Colors.black.withOpacity(0.86), indent: 22, endIndent: 20),
            SizedBox(height: 52),
            Icon(Icons.calendar_today, size: 28),
            SizedBox(height: 25),
            Divider(color: Colors.black),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 11),
        child: Container(), // Assuming this is not implemented yet
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 67,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 141, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              ),
              // child: Image.asset("assets/images/Untitled1Recovered.png", height: 44, width: 143),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 16,
              width: 12,
              margin: EdgeInsets.only(right: 53),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Text("2", style: TextStyle(fontSize: 18)),
                  Text("2", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionTextField() {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        // Positioned(top: 4, left: 119, child: Image.asset("assets/images/next.png", height: 5, width: 5)),
        // Positioned(top: 3, left: 115, child: Image.asset("assets/images/next.png", height: 5, width: 5)),
        SizedBox(
          height: 21,
          width: 301,
          child: TextField(
            controller: prescribedController,
            decoration: InputDecoration(
              hintText: "Prescribed",
              hintStyle: TextStyle(fontSize: 16),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropDown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 63),
      child: DropdownButton<String>(
        hint: Text("Time", style: TextStyle(fontSize: 16)),
        items: dropdownItemList.map((item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: 127,
      height: 36,
      child: ElevatedButton(onPressed: () {}, child: Text(text)),
    );
  }
}
