// import 'dart:io'; 
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart'; 
// import 'package:image_picker/image_picker.dart'; 
// import 'constants.dart';

// File? videoFile; 
// final picker = ImagePicker();


// class Upload extends StatelessWidget { 
//  const Upload(); 

// @override 
// Widget build(BuildContext context) { 
// 	return MaterialApp( 
// 	theme: ThemeData(primaryColor: Colors.green), 
// 	home: const VideoSelector(), 
// 	debugShowCheckedModeBanner: false, 
// 	); 
// } 
// } 

// class VideoSelector extends StatefulWidget { 
// const VideoSelector(); 

// @override 
// State<VideoSelector> createState() => _VideoSelectorState(); 
// } 

// class _VideoSelectorState extends State<VideoSelector> { 
// File? galleryFile; 
// final picker = ImagePicker(); 
// @override Widget build(BuildContext context) { 
	
// 	// display image selected from gallery 
	
// 	return Scaffold( 
// 		appBar: AppBar( 
// 			title: const Text('Virtual Clinic'), 
// 			backgroundColor: Colors.green, 
// 			actions: const [], 
// 		), 
// 		body: Builder( 
// 			builder: (BuildContext context) { 
// 				return Center( 
// 					child: Column( 
// 						mainAxisAlignment: MainAxisAlignment.center, 
// 						children: [ 
// 							Container(
// 								decoration: BoxDecoration(
// 									border: Border.all(color: Colors.black, width: 2), // Border decoration
// 									borderRadius: BorderRadius.circular(10), // Rounded corners
// 								),
// 								padding: EdgeInsets.all(10), // Padding for contents
// 								child: Column(
// 									children: [
// 										Text(
// 											"Q1 : How have you been feeling lately", // Text to display above buttons
// 											style: TextStyle(
// 												fontSize: 18,
// 												fontWeight: FontWeight.bold,
// 											),
// 										),
// 										ElevatedButton( 
// 											style: ButtonStyle( 
// 												backgroundColor: MaterialStateProperty.all(Colors.green)), 
// 											child: const Text('Upload 1'), 
// 											onPressed: () { 
// 												_showPicker(context: context); 
// 											}, 
// 										),
// 									],
// 								),
// 							),
// 							SizedBox(height: 40), // Add some space between containers
// 							Container(
// 								decoration: BoxDecoration(
// 									border: Border.all(color: Colors.black, width: 2), // Border decoration
// 									borderRadius: BorderRadius.circular(10), // Rounded corners
// 								),
// 								padding: EdgeInsets.all(10), // Padding for contents
// 								child: Column(
// 									children: [
// 										Text(
// 											"Q2 : Have you experienced any unusual thoughts?", // Text to display above buttons
// 											style: TextStyle(
// 												fontSize: 18,
// 												fontWeight: FontWeight.bold,
// 											),
// 										),
// 										ElevatedButton( 
// 											style: ButtonStyle( 
// 												backgroundColor: MaterialStateProperty.all(Colors.green)), 
// 											child: const Text('Upload 2'), 
// 											onPressed: () { 
// 												_showPicker(context: context); 
// 											}, 
// 										),
// 									],
// 								),
// 							),
// 							SizedBox(height: 40), // Add some space between containers
// 							Container(
// 								decoration: BoxDecoration(
// 									border: Border.all(color: Colors.black, width: 2), // Border decoration
// 									borderRadius: BorderRadius.circular(10), // Rounded corners
// 								),
// 								padding: EdgeInsets.all(10), // Padding for contents
// 								child: Column(
// 									children: [
// 										Text(
// 											"Q3 : How are you daily activites?", // Text to display above buttons
// 											style: TextStyle(
// 												fontSize: 18,
// 												fontWeight: FontWeight.bold,
// 											),
// 										),
// 										ElevatedButton( 
// 											style: ButtonStyle( 
// 												backgroundColor: MaterialStateProperty.all(Color(0xff0EBE7F))), 
// 											child: const Text('Upload 3'), 
// 											onPressed: () { 
//                      setState(() {
//                         //  postData(
//                         //   PatientHistoryId: 1,
//                         //   Videofile: File(galleryFile!.path),
//                         //   Question: 4,
                         
//                         // );
//                      });
// 												_showPicker(context: context); 
                       
// 											}, 
// 										),
// 									],
// 								),
// 							),
// 							const SizedBox( 
// 								height: 20, 
// 							), 
// 							SizedBox( 
// 								height: 200.0, 
// 								width: 300.0, 
// 								child: galleryFile == null 
// 									? const Center(child: Text('Sorry nothing selected!!')) 
// 									: Center(child: Text(galleryFile!.path)), 
// 							), 
			
// 						], 
// 					), 
// 				); 
// 			}, 
// 		), 
// 	); 
// }

//  Future<void> postData({
//     required int Question,
   
//     required int PatientHistoryId,
//     required File Videofile,
  
//   }) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse('$apiUrl/PatientVideoCallResponse'));

//       // Add fields to the request

//       request.fields['question'] = Question.toString();
//       request.fields['patient_history_id'] = PatientHistoryId.toString();
     

//       // Add image file to the request
//       request.files.add(await http.MultipartFile.fromPath('videofile', Videofile.path));

//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         print('Data posted successfully');
//       } else {
//         print('Failed to post data. Error: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }


// // void uploadToDatabase(String filePath) async {
// //   // Define your API endpoint
// //   var Url = Uri.parse('$apiUrl/PatientVideoCallResponse');

// //   try {
// //     // Make a POST request to your API endpoint
// //     var response = await http.post(
// //       Url,
// //       body: {'file_path': filePath},
// //     );

// //     // Check if the request was successful
// //     if (response.statusCode == 200) {
// //       print('File uploaded successfully');
// //     } else {
// //       print('Error uploading file: ${response.reasonPhrase}');
// //     }
// //   } catch (e) {
// //     print('Error uploading file: $e');
// //   }
// // }

// // // Call this function to upload the file to your database
// // void uploadFileToDatabase() {
// //   // Check if galleryFile is not null
// //   if (galleryFile != null) {
// //     // Get the file path
// //     String filePath = galleryFile!.path;

// //     // Call the uploadToDatabase function
// //     uploadToDatabase(filePath);
// //   } else {
// //     print('No file selected');
// //   }
// // }

 

// void _showPicker({ 
// 	required BuildContext context, 
// }) { 
// 	showModalBottomSheet( 
// 	context: context, 
// 	builder: (BuildContext context) { 
// 		return SafeArea( 
// 		child: Wrap( 
// 			children: <Widget>[ 
// 			ListTile( 
// 				leading: const Icon(Icons.photo_library), 
// 				title: const Text('Gallery'), 
// 				onTap: () { 
// 				getVideo(ImageSource.gallery); 
// 				Navigator.of(context).pop(
//            postData(
//                           PatientHistoryId: 1,
//                           Videofile: galleryFile!,
//                           Question: 1,
                         
//                         ),

//         ); 
// 				}, 
// 			), 
// 			ListTile( 
// 				leading: const Icon(Icons.photo_camera), 
// 				title: const Text('Camera'), 
// 				onTap: () { 
// 				getVideo(ImageSource.camera); 
// 				Navigator.of(context).pop(); 
// 				}, 
// 			), 
// 			], 
// 		), 
// 		); 
// 	}, 
// 	); 
// } 

// Future getVideo( 
// 	ImageSource img, 
// ) async { 
// 	final pickedFile = await picker.pickVideo( 
// 		source: img, 
// 		preferredCameraDevice: CameraDevice.front, 
// 		maxDuration: const Duration(minutes: 10)); 
// 	XFile? xfilePick = pickedFile; 
// 	setState( 
// 	() { 
// 		if (xfilePick != null) { 
// 		galleryFile = File(pickedFile!.path); 
// 		} else { 
// 		ScaffoldMessenger.of(context).showSnackBar(// is this context <<< 
// 			const SnackBar(content: Text('Nothing is selected'))); 
// 		} 
// 	}, 
// 	); 
// } 
// } 
