import 'package:flutter/material.dart';
import 'package:mcqs/MCQs.dart';
import 'package:mcqs/McqsWithResponse.dart';

class GetStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double fem = MediaQuery.of(context).size.width / 500; // Adjust according to your design
    // double ffem = MediaQuery.of(context).size.width / 400;
    double fem = 1; // You should define your fem value appropriately
    double ffem = 1; // You should define your ffem value appropriately

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0.33 * fem, 0 * fem),
              //   width: 143.67 * fem,
              //   height: 44.27 * fem,
              //   // child: Image.network(
              //   //   '[Image url]',
              //   //   fit: BoxFit.cover,
              //   // ),
              // ),
              Container(
                margin: EdgeInsets.fromLTRB(7 * fem, 77 * fem, 0 * fem, 0 * fem),
                child: Text(
                  'Welcome to the Psychologist Test\n',
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.2 * ffem / fem,
                    color: Color(0xff111111),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(39 * fem, 59 * fem, 35 * fem, 178 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(1 * fem, 15 * fem, 0 * fem, 103 * fem),
                      width: 281 * fem,
                      height: 350 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20 * fem),
                        child: Image.asset(
                          'lib/images/Rectangle 83.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the MCQs screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => McqsWithResponse()),
                        );
                      },
                      child: Container(
                        width: 190,
                        height: 40 * fem,
                        decoration: BoxDecoration(
                          color: Color(0xff0ebe7f),
                          borderRadius: BorderRadius.circular(20 * fem),
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
                            'Get Started',
                            style: TextStyle(
                              fontSize: 19.2903232574 * ffem,
                              fontWeight: FontWeight.w800,
                              height: 1.2 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



void main() {
  runApp(MaterialApp(
    home: GetStart(),
  ));
}
