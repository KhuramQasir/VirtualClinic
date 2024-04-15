import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mcqs/Api.dart';
import 'package:mcqs/Camera.dart';
import 'package:mcqs/GetStart.dart';
import 'package:mcqs/Home.dart';
import 'package:mcqs/Lock.dart';
import 'package:mcqs/Login.dart';
import 'package:mcqs/MCQs.dart';
import 'package:mcqs/McqsWithResponse.dart';
import 'package:mcqs/PatientHome.dart';
import 'package:mcqs/PatientSideSchedule.dart';
import 'package:mcqs/Session.dart';
import 'package:mcqs/SessionWithResponse.dart';
import 'package:mcqs/Signup.dart';
import 'package:mcqs/Splash.dart';
import 'package:mcqs/VideoCall.dart';
import 'package:path_provider/path_provider.dart';

var cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // FlutterError.onError = (details) {
  // FlutterError.presentError(details);
  //  };

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Splash()));
}
