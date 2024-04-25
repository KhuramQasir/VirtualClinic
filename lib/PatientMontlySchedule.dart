import 'package:flutter/material.dart';
import 'package:mcqs/Home.dart';

class PatientMonthlySchedule extends StatefulWidget {
  const PatientMonthlySchedule({Key? key}) : super(key: key);

  @override
  _PatientMonthlyScheduleState createState() =>
      _PatientMonthlyScheduleState();
}

class _PatientMonthlyScheduleState extends State<PatientMonthlySchedule> {
  List<DateTime?> selectedDates = List.filled(5, null);

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
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                selectedDates[index] != null
                                    ? " $index - ${selectedDates[index]!.day}/${selectedDates[index]!.month}/${selectedDates[index]!.year} ${selectedDates[index]!.hour}:${selectedDates[index]!.minute}"
                                    : " $index",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _selectDateTime(context, index);
                              },
                              child: Text("Select Date & Time"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToPatientReport(context); // Navigate to another screen
              },
              child: Text("Accept"),
            ),
          ],
        ),
      ),
    );
  }

  // Function to open date picker for a specific index
  Future<void> _selectDateTime(BuildContext context, int index) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDates[index] = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  // Function to navigate to another screen
  void navigateToPatientReport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PatientMonthlySchedule(),
  ));
}
