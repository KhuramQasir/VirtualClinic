import 'package:flutter/material.dart';
import 'package:mcqs/DoctorSide/Doctordashboard.dart';

class SelectQuestion extends StatelessWidget {

 List<String> PQuestion = [];
 
SelectQuestion({
 required this.PQuestion
});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
             
                
                SizedBox(height: 25),
                Text(
                  "Remaining time 3:49",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red[800],
                  ),
                ),
                SizedBox(height: 6),
                Divider(
                  color: Colors.black.withOpacity(0.86),
                  indent: 52,
                  endIndent: 61,
                ),
                SizedBox(height: 7),
                Container(
                decoration:BoxDecoration(
                 borderRadius: BorderRadius.circular(20), // Adjust the radius as needed

                  border: Border.all()
                ),
                width: 350,
                height: 400,
                child: ListView.builder(
      itemCount: PQuestion.length,
      itemBuilder: (context, index) {
        // Get the current question from the list
        final question = PQuestion[index];

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
  
              ),
                SizedBox(height: 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Start"),
                    ),
                    SizedBox(width: 31),
                    ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Doctordashboard()),
                  );
                      },
                      child: Text("End"),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.only(left: 11.0),
         
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

}
  
