import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/constants.dart';




Future<Map<String, dynamic>> fetchAdminById(int id) async {
  final url = Uri.parse('$apiUrl/getadminbyid/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load admin data');
  }
}

class AdminDetailScreen extends StatefulWidget {
  final int adminId;


  AdminDetailScreen({required this.adminId, });

  @override
  _AdminDetailScreenState createState() => _AdminDetailScreenState();
}

class _AdminDetailScreenState extends State<AdminDetailScreen> {
  Map<String, dynamic>? adminData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAdminData();
  }

  Future<void> fetchAdminData() async {
    try {
      final data = await fetchAdminById(widget.adminId);
      setState(() {
        adminData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching admin data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Details'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : adminData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${adminData!['name']}'),
                      Text('Age: ${adminData!['age']}'),
                      Text('CNIC: ${adminData!['cnic']}'),
                      Text('DOB: ${adminData!['dob']}'),
                      Text('Email: ${adminData!['email']}'),
                      Text('Gender: ${adminData!['gender']}'),
                      Text('ID: ${adminData!['id']}'),
                      Text('User ID: ${adminData!['user_id']}'),
                      // Do not display the password for security reasons
                    ],
                  ),
                )
              : Center(child: Text('Failed to load admin data')),
    );
  }
}
