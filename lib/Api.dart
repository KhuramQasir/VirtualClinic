// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:mcqs/function.dart';

// class API extends StatefulWidget {
//   const API({super.key});

//   @override
//   State<API> createState() => _APIState();
// }

// class _APIState extends State<API> {
//   String url = '';
//   var data;
//   String output = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Simple Flask APP'),
//         ),
//         body: Center(
//             child: Column(
//           children: [
//             TextField(onChanged: (value) {
//               url = 'http://10.0.2.2:5000/api?query=' + value.toString();
//             }),
//             TextButton(
//               onPressed: () async {
//                 data = await fetchdata(url);
//                 var decoded =jsonDecode(data);
//                 setState(() {
//                   output = decoded['output'];
//                 });
//               },
//               child: Text(
//                 'Fetch ACS',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             Text(output,
//             style:TextStyle(fontSize: 40,color:Colors.green))
//           ],
//         )));
//   }
// }
