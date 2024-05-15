import 'package:flutter/material.dart';

class DoctorRanking extends StatefulWidget {
  const DoctorRanking({Key? key}) : super(key: key);

  @override
  _DoctorRankingState createState() => _DoctorRankingState();
}

TextEditingController editTextController = TextEditingController();

class _DoctorRankingState extends State<DoctorRanking> {
  int? selectedRating; // Variable to store the selected rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            
              SizedBox(height: 18),
              Text("Doctor Rating", style: TextStyle(fontSize: 25)),
              SizedBox(height: 20),
              _buildView1(context, 2),
              SizedBox(height: 20),
              _buildView2(context, 3),
              SizedBox(height: 20),
              _buildView3(context, 1),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 47),
                  child: Text("Feedback:"),
                ),
              ),
              SizedBox(height: 5),
             Padding(
  padding: EdgeInsets.symmetric(horizontal: 13),
  child: TextFormField(
    controller: editTextController,
    textInputAction: TextInputAction.done,
    style: TextStyle(color: Colors.white), // Text color
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.green, // Background color
      hintText: 'Feedback',
      hintStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 34, horizontal: 20),
    ),
  ),
),

              SizedBox(height: 61),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(127, 36),
                  primary: Colors.green, // Background color
                  onPrimary: Colors.white, // Text color
                ),
                child: Text("Rate"),
              ),
              SizedBox(height: 19),
         
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildView1(BuildContext context, int row) {
    return Row(
      children: [
        Radio<int>(
          value: row,
          groupValue: selectedRating,
          onChanged: (value) {
            setState(() {
              selectedRating = value;
            });
          },
        ),
        SizedBox(width: 16), // Spacing between widgets
        // Star Icons
        Icon(Icons.star, size: 20),
      ],
    );
  }

  Widget _buildView2(BuildContext context, int row) {
    return Row(
      children: [
        Radio<int>(
          value: row,
          groupValue: selectedRating,
          onChanged: (value) {
            setState(() {
              selectedRating = value;
            });
          },
        ),
        SizedBox(width: 16), // Spacing between widgets
        // Star Icons
        Icon(Icons.star, size: 20),
        SizedBox(width: 4), // Spacing between stars
        Icon(Icons.star, size: 20),
      ],
    );
  }

  Widget _buildView3(BuildContext context, int row) {
    return Row(
      children: [
        Radio<int>(
          value: row,
          groupValue: selectedRating,
          onChanged: (value) {
            setState(() {
              selectedRating = value;
            });
          },
        ),
        SizedBox(width: 16), // Spacing between widgets
        // Star Icons
        Icon(Icons.star, size: 20),
        SizedBox(width: 4), // Spacing between stars
        Icon(Icons.star, size: 20),
        SizedBox(width: 4), // Spacing between stars
        Icon(Icons.star, size: 20),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      child: Container(height: 56),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DoctorRanking(),
  ));
}
