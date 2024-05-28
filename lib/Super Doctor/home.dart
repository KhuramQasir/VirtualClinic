import 'package:flutter/material.dart';
import 'package:mcqs/Super%20Doctor/doctorsList.dart';

class SuperDoctorHome extends StatelessWidget {
  const SuperDoctorHome({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Text('Welcome to the Virtual psycology',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           SizedBox(height: 50,),
          Container(
            child: Image.asset('lib/images/home.jpeg',width:double.infinity ,),
          ),
          SizedBox(height: 70,),
          Container(width: 300, child: ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green),foregroundColor: WidgetStatePropertyAll(Colors.white)), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DoctorsListPage();
            }));
          }, child: Text('Get Started')))
        ],
      ),
    );

  }
}