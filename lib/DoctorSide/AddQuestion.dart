import 'package:flutter/material.dart';
import 'package:mcqs/DoctorSide/SelectQuestion.dart';
import 'package:mcqs/UploadVideo/Model.dart';

class AddQuestion extends StatefulWidget {
  AddQuestion({Key? key}) : super(key: key);
  
  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {


  List<String> AddQuestion = [];

  final TextEditingController editTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              
              const SizedBox(height: 19),
             
              const SizedBox(height: 21),
              SizedBox(
                width: 199,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Enter Your Questions \n",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                     
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 15),
            
              const SizedBox(height: 1),
              SizedBox(
                height: 53,
                width: 331,
                child: TextFormField(
                  controller: editTextController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        AddQuestion.add(editTextController.text);
                      });
                    },
                    child: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green,
                      fixedSize: const Size(127, 36),
                    ),
                  ),
                  const SizedBox(width: 13),
                  ElevatedButton(
                    onPressed: () {

                        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectQuestion(PQuestion: AddQuestion,)),
                  );
                    },
                    child: const Text("Next"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green,
                      fixedSize: const Size(127, 36),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 44),
             
              Container(
                decoration:BoxDecoration(
                 borderRadius: BorderRadius.circular(20), // Adjust the radius as needed

                  border: Border.all()
                ),
                width: 350,
                height: 400,
                child: ListView.builder(
      itemCount: AddQuestion.length,
      itemBuilder: (context, index) {
        // Get the current question from the list
        final question = AddQuestion[index];

        return ListTile(
            leading: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          title:  Text(question), // Display the question text
              );
            },
          ),
  
              )
             
             
            ],
          ),
        ),
        
        
      ),
    );
  }

  Widget _buildUntitledRecovered() {
    return SizedBox(
      height: 67,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 141, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
             
            ),
          ),
     
        ],
      ),
    );
  }

  
}

   
  

