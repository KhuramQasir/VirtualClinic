import 'package:flutter/material.dart';
import 'package:mcqs/Home.dart';




class VideoCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      
        body: VideoCalla(),
      ),
      routes: {
       '/home': (context) => HomeScreen(),
       '/videocall':(context) => VideoCall(), // Define route for Session Screen
      },
    );
  }
}
class VideoCalla extends StatelessWidget {
  
  
  @override
  
  
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 430.0; // Assuming 375 is the base width
    double ffem = MediaQuery.of(context).textScaleFactor;
    
 void navigateToHome() {
   
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

    return  Stack(
      children: [
        Positioned(
          left: 0 * fem,
          top: 0 * fem,
          child: Align(
            child: SizedBox(
              width: 429 * fem,
              height: 926 * fem,
              child: Image.asset(
                'lib/images/image 1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: 157 * fem,
          top: 917 * fem,
          child: Align(
            child: SizedBox(
              width: 115 * fem,
              height: 2 * fem,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12 * fem),
                  border: Border.all(color: Color(0xff000000)),
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 180 * fem,
          top: 78 * fem,
          child: Align(
            child: SizedBox(
              width: 72 * fem,
              height: 32 * fem,
              child: Text(
                '1:12',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 26.5039615631 * ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.2 * ffem / fem,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
        ),
                Positioned(
          left: 160 * fem,
          top: 839.0833230019 * fem,
          child: Container(
            width: 135 * fem,
            height: 30.92 * fem,
            child: GestureDetector(
              onTap: () {
                // Action to perform when button is tapped
                              Navigator.pushNamed(context, '/home');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 8.08 * fem),
                    width: 11.67 * fem,
                    height: 1.83 * fem,
                    // child: Image.network(
                    //   '[Image url]',
                    //   width: 11.67 * fem,
                    //   height: 5.83 * fem,
                    // ),
                  ),
                  Text(
                    'Swipe back to menu',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.2125 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 125 * fem,
          top: 730 * fem,
          child: Container(
            width: 206 * fem,
            height: 52 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(14 * fem, 14 * fem, 14 * fem, 14 * fem),
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 250, 43, 43),
                    borderRadius: BorderRadius.circular(26 * fem),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'lib/images/videocall.png',
                        width: 24 * fem,
                        height: 24 * fem,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 25 * fem),
                Container(
                  padding: EdgeInsets.fromLTRB(14 * fem, 14 * fem, 14 * fem, 14 * fem),
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(26 * fem),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'lib/images/Call.png',
                        width: 24 * fem,
                        height: 24 * fem,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 25 * fem),
               Positioned(
          left: 125 * fem,
          top: 730 * fem,
          child: GestureDetector(
            onTap: () {
              // Action to perform when button is tapped
              Navigator.pushNamed(context, '/home');

            },
            child: Container(
              padding: EdgeInsets.fromLTRB(14 * fem, 14 * fem, 14 * fem, 14 * fem),
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(26 * fem),
              ),
              child: Center(
                child: SizedBox(
                  width: 24 * fem,
                  height: 24 * fem,
                  child: Image.asset(
                    'lib/images/Voice.png',
                    width: 24 * fem,
                    height: 24 * fem,
                  ),
                ),
              ),
            ),
          ),
        ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 198 * fem,
          top: 688 * fem,
          child: Align(
            child: SizedBox(
              width: 60 * fem,
              height: 17 * fem,
              child: Text(
                '00:05:24',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.2125 * ffem / fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 158 * fem,
          top: 661 * fem,
          child: Align(
            child: SizedBox(
              width: 148 * fem,
              height: 20 * fem,
              child: Text(
                'Dr. Marcus Horizon',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2125 * ffem / fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 320 * fem,
          top: 40 * fem,
          child: Align(
            child: SizedBox(
              width: 97 * fem,
              height: 145 * fem,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15 * fem),
                  color: Color(0xffc4c4c4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'lib/images/image 1.jpg',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}





// // ignore: file_names
// import 'package:khurram_project/widgets/custom_icon_button.dart';
// import 'package:flutter/material.dart';
// import 'package:khurram_project/core/app_export.dart';
// import 'package:mcqs/widgets';

// class VideoCallScreen extends StatelessWidget {
//   const VideoCallScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           height: SizeUtils.height,
//           width: double.maxFinite,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(18.h, 9.v, 18.h, 122.v),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       _buildEight(context),
//                       SizedBox(height: 9.v),
//                       _buildArrowTwo(context),
//                       Spacer(),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Container(
//                           height: 110.v,
//                           width: 80.h,
//                           margin: EdgeInsets.only(right: 16.h),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 14.h,
//                             vertical: 29.v,
//                           ),
//                           decoration: AppDecoration.fillPrimary.copyWith(
//                             borderRadius: BorderRadiusStyle.roundedBorder10,
//                           ),
//                           child: CustomImageView(
//                             imagePath: ImageConstant.imgLockBlack900,
//                             height: 52.adaptSize,
//                             width: 52.adaptSize,
//                             alignment: Alignment.center,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 18.h,
//                     vertical: 7.v,
//                   ),
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                         ImageConstant.imgGroup327,
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       SizedBox(height: 17.v),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                               top: 54.v,
//                               bottom: 58.v,
//                             ),
//                             child: Text(
//                               "10:12",
//                               style: CustomTextStyles.headlineMediumLato,
//                             ),
//                           ),
//                           CustomImageView(
//                             imagePath: ImageConstant.imgImage,
//                             height: 145.v,
//                             width: 97.h,
//                             radius: BorderRadius.circular(
//                               15.h,
//                             ),
//                             margin: EdgeInsets.only(left: 64.h),
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       Padding(
//                         padding: EdgeInsets.only(right: 105.h),
//                         child: Text(
//                           "Dr. Marcus Horizon",
//                           style: CustomTextStyles
//                               .titleMediumInterWhiteA700SemiBold,
//                         ),
//                       ),
//                       SizedBox(height: 8.v),
//                       Padding(
//                         padding: EdgeInsets.only(right: 152.h),
//                         child: Text(
//                           "00:05:24",
//                           style: CustomTextStyles.bodyMediumInterWhiteA700,
//                         ),
//                       ),
//                       SizedBox(height: 24.v),
//                       Padding(
//                         padding: EdgeInsets.only(right: 79.h),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             CustomIconButton(
//                               height: 52.adaptSize,
//                               width: 52.adaptSize,
//                               padding: EdgeInsets.all(14.h),
//                               child: CustomImageView(
//                                 imagePath: ImageConstant.imgGroup71,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 25.h),
//                               child: CustomIconButton(
//                                 height: 52.adaptSize,
//                                 width: 52.adaptSize,
//                                 padding: EdgeInsets.all(14.h),
//                                 child: CustomImageView(
//                                   imagePath: ImageConstant.imgGroup70,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 25.h),
//                               child: CustomIconButton(
//                                 height: 52.adaptSize,
//                                 width: 52.adaptSize,
//                                 padding: EdgeInsets.all(14.h),
//                                 child: CustomImageView(
//                                   imagePath: ImageConstant.imgGroup69,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 50.v),
//                       CustomImageView(
//                         imagePath: ImageConstant.imgArrowUp,
//                         height: 20.adaptSize,
//                         width: 20.adaptSize,
//                         margin: EdgeInsets.only(right: 172.h),
//                       ),
//                       SizedBox(height: 2.v),
//                       Padding(
//                         padding: EdgeInsets.only(right: 116.h),
//                         child: Text(
//                           "Swipe back to menu",
//                           style: CustomTextStyles.bodyMediumInterWhiteA700,
//                         ),
//                       ),
//                       SizedBox(height: 45.v),
//                       Align(
//                         alignment: Alignment.center,
//                         child: SizedBox(
//                           width: 115.h,
//                           child: Divider(
//                             color: appTheme.black900,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildEight(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 14.h,
//         right: 17.h,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 2.v),
//             child: Text(
//               "9:20AM",
//               style: CustomTextStyles.labelMediumInterBlack900,
//             ),
//           ),
//           CustomImageView(
//             imagePath: ImageConstant.imgSettings,
//             height: 18.v,
//             width: 56.h,
//           ),
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildArrowTwo(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         CustomImageView(
//           imagePath: ImageConstant.imgArrow2,
//           height: 2.v,
//           width: 19.h,
//           margin: EdgeInsets.only(
//             top: 12.v,
//             bottom: 10.v,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//             top: 6.v,
//             bottom: 4.v,
//           ),
//           child: Text(
//             "end-to-end encryted",
//             style: CustomTextStyles.labelMediumGray600,
//           ),
//         ),
//         CustomImageView(
//           imagePath: ImageConstant.imgIcRoundPersonAdd,
//           height: 24.adaptSize,
//           width: 24.adaptSize,
//         ),
//       ],
//     );
//   }
// }
