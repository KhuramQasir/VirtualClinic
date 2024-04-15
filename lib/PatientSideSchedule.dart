// import 'package:flutter/material.dart';

// class PatientSideScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double fem = screenWidth / 100;
//     double ffem = fem / 16;

//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.fromLTRB(7 * fem, 13 * fem, 6 * fem, 2 * fem),
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 19 * fem),
//               padding: EdgeInsets.fromLTRB(23 * fem, 5 * fem, 9 * fem, 4 * fem),
//               width: double.infinity,
//               height: 38 * fem,
//               decoration: BoxDecoration(
//                 color: Color(0xff166296),
//                 borderRadius: BorderRadius.circular(20 * fem),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0x3f000000),
//                     offset: Offset(0 * fem, 0 * fem),
//                     blurRadius: 1 * fem,
//                   ),
//                 ],
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Container(
//                   //   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 5 * fem, 1 * fem),
//                   //   width: 20 * fem,
//                   //   height: 20 * fem,
//                   //   child: Image.network(
//                   //     '[Image url]',
//                   //     width: 20 * fem,
//                   //     height: 20 * fem,
//                   //   ),
//                   // ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 244 * fem, 0 * fem),
//                     child: Text(
//                       'Jamal Butt',
//                       style: TextStyle(
//                         fontSize: 17.2131156921 * ffem,
//                         fontWeight: FontWeight.w800,
//                         color: Color(0xdbffffff),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 29 * fem,
//                     height: double.infinity,
//                     child: Stack(
//                       children: [
//                         // Positioned(
//                         //   left: 0 * fem,
//                         //   top: 0 * fem,
//                         //   child: Align(
//                         //     child: SizedBox(
//                         //       width: 29 * fem,
//                         //       height: 29 * fem,
//                         //       child: Image.network(
//                         //         '[Image url]',
//                         //         width: 29 * fem,
//                         //         height: 29 * fem,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         Positioned(
//                           left: 15 * fem,
//                           top: 2 * fem,
//                           child: Align(
//                             child: SizedBox(
//                               width: 14 * fem,
//                               height: 14 * fem,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(7 * fem),
//                                   color: Color(0xff4ed7e0),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 19 * fem,
//                           top: 3 * fem,
//                           child: Align(
//                             child: SizedBox(
//                               width: 6 * fem,
//                               height: 12 * fem,
//                               child: Text(
//                                 '3',
//                                 style: TextStyle(
//                                   fontSize: 10 * ffem,
//                                   fontWeight: FontWeight.w800,
//                                   color: Color(0xffb42323),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(49 * fem, 0 * fem, 51 * fem, 11 * fem),
//               width: double.infinity,
//               height: 4 * fem,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12 * fem),
//                 color: Color(0xdb000000),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 12 * fem, 4 * fem),
//               child: Text(
//                 ' Your Monthly Schedule',
//                 style: TextStyle(
//                   fontSize: 24 * ffem,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xdb111111),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 22 * fem),
//               constraints: BoxConstraints(maxWidth: 247 * fem),
//               child: Text(
//                 'Please Ensure to Meet the Doctor\n         on the Following Dates',
//                 style: TextStyle(
//                   fontSize: 14.8999996185 * ffem,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: 0.7449999809 * fem,
//                   color: Color(0xff000000),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(24 * fem, 0 * fem, 26 * fem, 27 * fem),
//               padding: EdgeInsets.fromLTRB(20 * fem, 17 * fem, 22 * fem, 80 * fem),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Color(0x6b0ebe7f),
//                 borderRadius: BorderRadius.circular(20 * fem),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Add your widgets for the monthly schedule here
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(141 * fem, 0 * fem, 148 * fem, 57 * fem),
//               width: double.infinity,
//               height: 35 * fem,
//               decoration: BoxDecoration(
//                 color: Color(0xff0ebe7f),
//                 borderRadius: BorderRadius.circular(10 * fem),
//               ),
//               child: Center(
//                 child: Text(
//                   'Book Next Appointment',
//                   style: TextStyle(
//                     fontSize: 14.8999996185 * ffem,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xdbffffff),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: PatientSideScreen(),
//   ));
// }
