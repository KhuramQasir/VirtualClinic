import 'package:flutter/material.dart';

class twoButtonsScreen extends StatelessWidget {
  const twoButtonsScreen({Key? key}) : super(key: key);

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
                  // Button pressed action
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
                  // Button pressed action
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
