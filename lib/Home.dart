import 'package:flutter/material.dart';
import 'package:mcqs/AdminSide/Admindashboard.dart';
import 'package:mcqs/DoctorSide/Doctordashboard.dart';

import 'package:mcqs/GetStart.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 500; // Adjust according to your design
    double ffem = MediaQuery.of(context).size.width / 400; // Adjust according to your design

    return Scaffold(
      
      body: Stack(
        
        children: [
          Positioned(
            left: 127 * fem,
            top: 150 * fem,
            child: Align(
              child: SizedBox(
                width: 174 * fem,
                height: 174 * fem,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(87 * fem),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x3f000000),
                        offset: Offset(0 * fem, -4 * fem),
                        blurRadius: 6 * fem,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 144 * fem,
            top: 190 * fem,
            child: Align(
              child: SizedBox(
                width: 140 * fem,
                height: 104 * fem,
                child: Image.asset(
                  'lib/images/p treatmanet 1.jpg', // Adjust with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(59 * fem, 400 * fem, 34 * fem, 155 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 0 * fem),
                  child: TextButton(
                    onPressed: () {   Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Admindashboard()));},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 354 * fem,
                      height: 49 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffd41f1f),
                        borderRadius: BorderRadius.circular(36 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000),
                            offset: Offset(0 * fem, 0 * fem),
                            blurRadius: 3.5 * fem,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'ADMIN',
                          style: TextStyle(
                            fontSize: 19.7826080322 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 41 * fem),
                Container(
                  margin: EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
                  child: TextButton(
                    onPressed: () {
  },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 354 * fem,
                      height: 49 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36 * fem),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff0074d9),
                          borderRadius: BorderRadius.circular(36 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000),
                              offset: Offset(0 * fem, 0 * fem),
                              blurRadius: 3.5 * fem,
                            ),
                          ],
                        ),
                        child: TextButton(
                           onPressed: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Doctordashboard()));
                            // to navigate to MCQs screen
                           },
                          child: Center(
                            child: Text(
                              'PSYCHOLOGIST',
                              style: TextStyle(
                                fontSize: 17.6476688385 * ffem,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 41 * fem),
                Container(
                  margin: EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
                  child: TextButton(
                      onPressed: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GetStart()));
                            // to navigate to MCQs screen
                          },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 354 * fem,
                      height: 49 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xff0ebe7f),
                        borderRadius: BorderRadius.circular(36 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000),
                            offset: Offset(0 * fem, 0 * fem),
                            blurRadius: 3.5 * fem,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'PATIENT',
                          style: TextStyle(
                            fontSize: 19.2903232574 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 441 * fem,
              height: 52 * fem,
              decoration: BoxDecoration(
                color: Color(0xff0ebe7f),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x59000000),
                    offset: Offset(0 * fem, 6 * fem),
                    blurRadius: 3 * fem,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
