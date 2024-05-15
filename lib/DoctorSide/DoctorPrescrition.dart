import 'package:flutter/material.dart';

class DoctorPrescrition extends StatelessWidget {
  DoctorPrescrition({Key? key}) : super(key: key);

  TextEditingController prescribedController = TextEditingController();

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
           
            SizedBox(height: 19),
            Divider(
              color: Color.fromARGB(255, 34, 195, 117).withOpacity(0.86),
              indent: 52,
              endIndent: 61,
            ),
            SizedBox(height: 26),
            Padding(
              padding: EdgeInsets.only(left: 126),
              child: Text(
                "Prescription",
                style: TextStyle(fontSize: 20),
              ),
            ),
         
             SizedBox(height: 19),
   _buildPrescribed(context),
            SizedBox(height: 19),
            Center(child: _buildDropDown(context)),
            SizedBox(height: 26),
            Center(child: _buildAdd(context)),
            SizedBox(height: 33),
            Center(child: _buildView(context)),
            SizedBox(height: 54),
            Center(child: _buildSet(context)),
            SizedBox(height: 56),
            Divider(
              color: Colors.black.withOpacity(0.86),
              indent: 22,
              endIndent: 20,
            ),
            SizedBox(height: 52),
           
          ],
        ),
      ),
      
    );
  }

  



  
  

  Widget _buildPrescribed1(BuildContext context) {
    return TextFormField(
      controller: prescribedController,
      decoration: InputDecoration(
        hintText: "Prescribed",
        filled: true,
        fillColor: Colors.green, // Button Background Color
      ),
    );
  }

  Widget _buildDropDown(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 63, vertical: 10),
      child: DropdownButton<String>(
        hint: Text("Time"),
        items: dropdownItemList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {},
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        isExpanded: true,
      ),
    );
  }
  Widget _buildPrescribed(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 63, vertical: 10),
      child: DropdownButton<String>(
        hint: Text("Prescribed"),
        items: dropdownItemList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {},
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        isExpanded: true,
      ),
    );
  }

  Widget _buildAdd(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Add"),
      style: ElevatedButton.styleFrom(
        primary: Colors.green, // Button Background Color
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    return Container(
      width: 386,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 23),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildViewRow("Walk/Morning:"),
          SizedBox(height: 68),
          _buildViewRow("Yoga/Anytime:"),
          SizedBox(height: 67),
          _buildViewRow("Listen Music/Night:"),
          SizedBox(height: 7),
        ],
      ),
    );
  }

  Widget _buildViewRow(String text) {
    return Row(
      children: [
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 7),
        Text(text),
      ],
    );
  }

  Widget _buildSet(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Set"),
      style: ElevatedButton.styleFrom(
        primary: Colors.green, // Button Background Color
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 50,
        color: Colors.blue, // Adjust color as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
