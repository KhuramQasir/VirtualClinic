import 'package:flutter/material.dart';

class Appointments extends StatefulWidget {
  Appointments({Key? key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  TextEditingController editTextController = TextEditingController();
  List<String> questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text(
                "Enter Your Questions \n Asked During the Video Session",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                "Enter",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: editTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _addQuestion();
                    },
                    child: Text("Add"),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Next"),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                "View",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestion(questions[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question),
        ],
      ),
    );
  }

  void _addQuestion() {
    setState(() {
      questions.add(editTextController.text);
      editTextController.clear();
    });
  }
}
