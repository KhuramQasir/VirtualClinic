import 'package:flutter/material.dart';
import 'package:mcqs/Super%20Doctor/sessionResponse.dart';
import 'package:mcqs/Super%20Doctor/videoResponse.dart';

class twoButtonsScreen extends StatelessWidget {
  String pid,date;
  twoButtonsScreen({required this.date,required this.pid});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(

          child: Center(
            child: Column(
              
              children: [
                SizedBox(height: 100,),
                Container(
                  width: 200,
                  child: ElevatedButton(
                                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Decrease the radius here
                    ),
                  ),
                                ),
                                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SuperDoctorSessionResponse(patientid: pid,date: date,);
                  }));
                                },
                                child: Text('Stimuli Session',style: TextStyle(color: Colors.white),),
                              ),
                ),
            SizedBox(height: 20,),
            Container(
                width: 200,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Decrease the radius here
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SuperDoctorVideoResponse(patientid: pid,date: date,);
                  }));
                },
                child: Text('Video Response',style: TextStyle(color: Colors.white),),
              ),
            ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
