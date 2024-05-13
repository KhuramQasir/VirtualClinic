import 'package:flutter/material.dart';

class ApproveAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approve Patient"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItem(context, "Zia", "Request to connect"),
            SizedBox(height: 32.0),
            _buildItem(context, "Khurram", "Request to connect"),
            SizedBox(height: 32.0),
            _buildItem(context, "Fahad", "Request to connect"),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String name, String subtitle) {
    return Card(
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
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    subtitle,
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
                  onPressed: () {},
                  icon: Icon(Icons.close, color: Colors.red),
                ),
                SizedBox(height: 8.0),
                Icon(Icons.check_circle_outline, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
