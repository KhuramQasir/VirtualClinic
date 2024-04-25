

import 'package:flutter/material.dart';
import 'package:mcqs/Home.dart';




class PatientMonthlySchedule extends StatelessWidget {
  const PatientMonthlySchedule ({Key? key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Monthly Schedule"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 12,
                    // backgroundImage: AssetImage('assets/jamal_avatar.jpg'),
                  ),
                  Text(
                    "Jamal Butt",
                    style: TextStyle(fontSize: 18),
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.grey,
                        // backgroundImage: AssetImage('assets/group_icon.jpg'),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Please Ensure to Meet the Doctor\n         on the Following Dates",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Sunday Item $index",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {navigateToPatientReport;},
              child: Text("Accept"),
            ),
          ],
        ),
      ),
    );
  }
  void navigateToPatientReport(BuildContext context) {
  Navigator.push(
    context,
     MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}

}
