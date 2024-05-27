import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcqs/AdminSide/AdminDetailScreen.dart';
import 'package:mcqs/AdminSide/DoctorInfo.dart';
import 'package:mcqs/constants.dart';



class ApprovePatients extends StatefulWidget {
  const ApprovePatients({Key? key}) : super(key: key);

  @override
  _ApprovePatientsState createState() => _ApprovePatientsState();
}

class _ApprovePatientsState extends State<ApprovePatients> {
  List<Map<String, dynamic>> patientsRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatientsRequests();
  }

  Future<void> fetchPatientsRequests() async {
    final url = Uri.parse('$apiUrl/doctor_requests');
    try {
      final response = await http.post(url, body: {'doctor_id': '$doctor_id_d'}); // Replace '1' with actual doctor ID

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> requestData = data['data'];
        final int statusCode = data['statusCode'];

        if (statusCode == 200) {
          if (mounted) {
            setState(() {
              patientsRequests = List<Map<String, dynamic>>.from(requestData);
              _isLoading = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          print('Failed to load admin requests');
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        print('Failed to load admin requests');
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print('Error: $error');
    }
  }

  Future<void> approveAdmin(int id) async {
    final url = Uri.parse('$apiUrl/Approve-admin/$id');
    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String message = data[0]['message'];
        final int statusCode = data[1];

        if (statusCode == 200) {
          setState(() {
            patientsRequests.removeWhere((admin) => admin['id'] == id);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        } else {
          print('Failed to approve admin');
        }
      } else {
        print('Failed to approve admin');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> rejectAdmin(int id) async {
    final url = Uri.parse('$apiUrl/delete-admin/$id');
    try {
      final response = await http.get(url);

      final data = json.decode(response.body);

      setState(() {
        patientsRequests.removeWhere((admin) => admin['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approve Admin"),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : patientsRequests.isEmpty
              ? Center(child: Text("No admin requests found"))
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: patientsRequests.map((admin) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: _buildItem(context, admin),
                      );
                    }).toList(),
                  ),
                ),
    );
  }

  Widget _buildItem(BuildContext context, Map<String, dynamic> admin) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDetailScreen(adminId: admin['id'],)),
        );
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      admin['name'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Request to connect",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      rejectAdmin(admin['id']);
                    },
                    icon: Icon(Icons.close, color: Colors.red),
                  ),
                  SizedBox(height: 8.0),
                  IconButton(
                    onPressed: () {
                      approveAdmin(admin['id']);
                    },
                    icon: Icon(Icons.check_circle_outline, color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
