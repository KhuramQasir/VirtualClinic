

import 'package:flutter/material.dart';
import 'package:mcqs/Login.dart';
import 'package:mcqs/Signup.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

 void navigateToLogin(BuildContext context) {
    // Navigate to Signup screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void navigateToSignup(BuildContext context) {
    // Navigate to Signup screen
    Navigator.push(
      context ,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Assuming SizeUtils.width is equivalent to full screen width
          height: MediaQuery.of(context)
              .size
              .height, // Assuming SizeUtils.height is equivalent to full screen height
          decoration: BoxDecoration(
            color: Colors
                .white, // Assuming appTheme.whiteA700 maps to Colors.white
            image: DecorationImage(
              image: AssetImage(
                  "lib/images/two-doctors-front-shelf-with-bookcase-background 1.jpg"), // Example path, replace with `ImageConstant.imgSplashScreenOne`
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal:
                    42.0, // Assuming .h is a height extension, replace with actual values or methods
                vertical:
                    108.0, // Assuming .v is a vertical extension, replace with actual values or methods
              ),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [Colors.black, Colors.black], // Example gradient, replace with `AppDecoration.gradientBlackToBlack`
              //   ),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Container(
                    width: 263.0, // Replace .h with actual values or methods
                    margin: EdgeInsets.only(
                        right:
                            80.0), // Replace .h with actual values or methods
                    child: Text(
                      "Welcome to the Virtual Psychology Clinic.",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white, // Example style
                        fontSize: 25.0, // Adjust the font size as needed
                        // Add other styling attributes if needed
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 18.0), // Replace .v with actual values or methods
                  Container(
                    width: 269.0, // Replace .h with actual values or methods
                    margin: EdgeInsets.only(
                        left: 7.0,
                        right:
                            67.0), // Replace .h with actual values or methods
                    child: Text(
                      "\"Discover healing, one virtual session at a time. Welcome to our virtual psychology clinic, where we're here to listen, support, and guide you on your journey to mental well-being.\"",
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white, // Example style
                        fontSize: 20.0, // Adjust the font size as needed
                        // Add other styling attributes if needed
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 44.0), // Replace .v with actual values or methods
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            7.0), // Replace .h with actual values or methods
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          // CustomElevatedButton needs to be replaced with an actual ElevatedButton if not defined
                          child: ElevatedButton(
                            onPressed: () => navigateToSignup(context),
                            child: Text("Sign Up"),
                                style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          minimumSize: const Size(270, 40),
                        ),
                          ),
                        ),
                        SizedBox(width: 10), // Space between buttons
                        Expanded(
                          // CustomOutlinedButton needs to be replaced with an actual OutlinedButton if not defined
                          child: ElevatedButton(
                            onPressed: () => navigateToLogin(context),
                            child: Text("Log In"),
                                style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          minimumSize: const Size(270, 40),
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
        ),
      ),
    );
  }
}
