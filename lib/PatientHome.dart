// import 'package:flutter/material.dart';
// import 'package:mcqs/Home.dart';

// class WelcomethreeScreen extends StatelessWidget {
//   WelcomethreeScreen({Key? key}) : super(key: key);

//   String radioGroup = "";

//   List<String> radioList = [
//     "lbl_terirrifying",
//     "lbl_fascinating",
//     "lbl_indifferent",
//     "lbl_cute"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: _buildAppBar(context),
//         body: SingleChildScrollView(
//           child: Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(
//               horizontal: 6,
//               vertical: 7,
//             ),
//             child: Column(
//               children: [
//                 _buildJamalButt(context),
//                 SizedBox(height: 28),
//                 Divider(
//                   color: Colors.black.withOpacity(0.86),
//                   indent: 54,
//                   endIndent: 47,
//                 ),
//                 SizedBox(height: 22),
//                 Text(
//                   "Look at this picture",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 216,
//                   width: 357,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(17),
//                     image: DecorationImage(
//                       image: AssetImage(
//                           "lib/images/Rectangle 83.jpg"), // Adjust the path to your image
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 27),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: 14,
//                       right: 59,
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 6,
//                           width: 6,
//                           margin: EdgeInsets.only(
//                             top: 10,
//                             bottom: 30,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(3),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             width: 322,
//                             margin: EdgeInsets.only(left: 13),
//                             child: Text(
//                               " What is your opinion about the dangerous dinosaur picture above?",
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 18),
//                 _buildGroup821(context),
//                 SizedBox(height: 5),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding: EdgeInsets.only(
//             left: 7,
//             right: 3,
//           ),
//           child: _buildBottomBar(context),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       title: Text("Virtual Clinic "),
//       backgroundColor: Colors.white,
//       elevation: 0,
//     );
//   }

//   Widget _buildJamalButt(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 1),
//       padding: EdgeInsets.symmetric(
//         horizontal: 5,
//         vertical: 4,
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         borderRadius: BorderRadius.circular(19),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
          
//           Padding(
//             padding: EdgeInsets.only(
//               left: 3,
//               top: 5,
//               bottom: 3,
//             ),
//             child: Text(
//               "Khurram",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Spacer(),
//           Stack(
//             alignment: Alignment.topRight,
//             children: [
              
//               Container(
//                 width: 14,
//                 margin: EdgeInsets.only(top: 2),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 3,
//                   vertical: 1,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.cyan,
//                   borderRadius: BorderRadius.circular(7),
//                 ),
//                 child: Text(
//                   "3",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGroup821(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(right: 3),
//             child: RadioListTile(
//               title: Text("Terirrifying."),
//               value: radioList[0],
//               groupValue: radioGroup,
//               onChanged: (value) {
//                 radioGroup = value.toString();
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: 25,
//               right: 3,
//             ),
//             child: RadioListTile(
//               title: Text("Fascinating."),
//               value: radioList[1],
//               groupValue: radioGroup,
//               onChanged: (value) {
//                 radioGroup = value.toString();
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: 3,
//               top: 27,
//             ),
//             child: RadioListTile(
//               title: Text("Indifferent."),
//               value: radioList[2],
//               groupValue: radioGroup,
//               onChanged: (value) {
//                 radioGroup = value.toString();
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: 27,
//               right: 3,
//             ),
//             child: RadioListTile(
//               title: Text("Cute."),
//               value: radioList[3],
//               groupValue: radioGroup,
//               onChanged: (value) {
//                 radioGroup = value.toString();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// void navigateToHome(BuildContext context) {
//     // Navigate to Signup screen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen()),
//     );
//   }
//   Widget _buildBottomBar(BuildContext context) {
//     return BottomAppBar(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: ()=> navigateToHome(context),
//           ),
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
//--------------------------------------------API--------------------------------------------
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:mcqs/Home.dart';

// class WelcomethreeScreen extends StatefulWidget {
//   @override
//   _WelcomethreeScreenState createState() => _WelcomethreeScreenState();
// }

// class _WelcomethreeScreenState extends State<WelcomethreeScreen> {
//   String selectedOption = "";
//   late Future<QuizData> quizData;

//   @override
//   void initState() {
//     super.initState();
//     quizData = fetchQuizData();
//   }

//   Future<QuizData> fetchQuizData() async {
//     // This is just an example URL, replace it with the actual API URL.
//     final response = await http.get(Uri.parse('http://192.168.100.22:5000/SessionDetails'));

//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response, then parse the JSON.
//       return QuizData.fromJson(jsonDecode(response.body));
//     } else {
//       // If the server did not return a 200 OK response, throw an exception.
//       throw Exception('Failed to load quiz data');
//     }
//   }

//   Future<void> postSelectedOption(String option) async {
//     // This is just an example URL, replace it with the actual API URL.
//     final response = await http.post(
//       Uri.parse('http://192.168.100.22:5000/SessionDetails'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'selectedOption': option,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response, show success message or handle accordingly.
//       print("Success! Option posted.");
//     } else {
//       // If the server did not return a 200 OK response, throw an exception.
//       throw Exception('Failed to post answer');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text("Virtual Clinic"),
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: FutureBuilder<QuizData>(
//           future: quizData,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("An error occurred"));
//             } else if (snapshot.hasData) {
//               return buildQuizContent(snapshot.data!, context);
//             } else {
//               return Center(child: Text("Unknown error"));
//             }
//           },
//         ),
//         // Other widget elements remain unchanged...
//       ),
//     );
//   }

//   Widget buildQuizContent(QuizData data, BuildContext context) {
//     // Use data to build your quiz UI
//     return SingleChildScrollView(
//       // Your existing UI code goes here, adjusted to use data from the QuizData object
//     );
//   }
// }

// class QuizData {
//   // Define your QuizData structure based on the JSON response you expect
//   final String imageUrl;
//   final String question;
//   final List<String> options;

//   QuizData({required this.imageUrl, required this.question, required this.options});

//   factory QuizData.fromJson(Map<String, dynamic> json) {
//     return QuizData(
//       imageUrl: json['imageUrl'],
//       question: json['question'],
//       options: List<String>.from(json['options']),
//     );
//   }
// }
//------------------------------Test---------------------------

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class WelcomethreeScreen extends StatefulWidget {
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomethreeScreen> {
//   late Future<List<QuestionData>> questionData;
//   String? selectedOption;

//   @override
//   void initState() {
//     super.initState();
//     questionData = fetchQuestionData();
    
//   }

//   Future<List<QuestionData>> fetchQuestionData() async {
//     final response = await http.get(Uri.parse('http://10.0.2.2:5000/SessionDetails'));

//     if (response.statusCode == 200) {
//       final List<dynamic> questionData = json.decode(response.body)[0];
//       return questionData.map((e) => QuestionData.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load question');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text("Virtual Clinic"),
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: FutureBuilder<List<QuestionData>>(
//           future: questionData,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
              
//               return ListView.builder(
                
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                 return buildQuestionContent(snapshot.data![index]);
//               },);
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             }
//             // By default, show a loading spinner.
//             return  CircularProgressIndicator();
//           },
//         ),
//         bottomNavigationBar: _buildBottomBar(context),
//       ),
//     );
//   }
//    Widget _buildBottomBar(BuildContext context) {
//     return BottomAppBar(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () {
//               // Handle Home Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Handle Search Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Handle Notifications Icon press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               // Handle Settings Icon press
//             },
//           ),
//         ],
//       ),
//     );
//   }


//   Widget buildQuestionContent(QuestionData data) {
//     return SingleChildScrollView(
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 7),
//         child: Column(
//           children: <Widget>[
//             Text(
//               "Look at this picture",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(height: 10),
//             Image.network(data.imageUrl),
//             SizedBox(height: 27),
//             Text(
//               data.questionText,
//               style: TextStyle(fontSize: 16),
//             ),
//             ...List.generate(data.options.length, (index) => RadioListTile<String>(
//                   title: Text(data.options[index]),
//                   value: data.options[index],
//                   groupValue: selectedOption,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedOption = value!;
//                     });
//                   },
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

//   // Add _buildBottomBar() and other necessary methods here
// }

// class QuestionData {
//   final int id;
//   final String imageUrl;
//   final List<String> options;
//   final String questionText;

//   QuestionData({
//     required this.id,
//     required this.imageUrl,
//     required this.options,
//     required this.questionText,
//   });

//   factory QuestionData.fromJson(Map<String, dynamic> json) {
//     return QuestionData(
//       id: json['id'],
//       imageUrl: json['image_url'],
//       options: [json['option_1'], json['option_2'], json['option_3'], json['option_4']],
//       questionText: json['question_text'],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mcqs/Session.dart';
import 'package:mcqs/SessionWithResponse.dart';
import 'package:mcqs/VideoCall.dart';

void main() {
  runApp(PatientHome());
}

class PatientHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Consultation Screen'),
        ),
        body: ConsultationScreen(),
      ),
      routes: {
       '/session': (context) => Session(),
       '/videocall':(context) => VideoCall(), // Define route for Session Screen
      },
    );
  }
}

class ConsultationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Consultations',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to Session Screen when button pressed
              Navigator.pushNamed(context, '/session');
            },
            child: Text('View Appointments'),
          ),
          SizedBox(height: 20),
          Text(
            'Session',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
             Navigator.pushNamed(context, '/session');
            },
            child: Text('Start Session'),
          ),
          SizedBox(height: 20),
          Text(
            'Video Call',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              // Action for Start Video button
              Navigator.pushNamed(context, '/videocall');
            },
            child: Text('Start Video'),
          ),
          SizedBox(height: 20),
          Text(
            'Report',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              // Action for Check Report button
            },
            child: Text('Check Report'),
          ),
        ],
      ),
    );
  }
}


