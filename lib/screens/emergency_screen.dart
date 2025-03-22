import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  // List of emergency contacts
  final List<Map<String, String>> emergencyContacts = [
    {"name": "Red Cross", "number": "907"},
    {"name": "Ambulance", "number": "991"},
    {"name": "Police", "number": "911"},
    {"name": "Fire Department", "number": "939"},
    {"name": "Surafiel", "number": "0941337762"}, // Add a custom contact
    {"name": "Zewdinesh", "number": "0945667762"}, 
  ];

  // List of health tips
  final List<String> healthTips = [
    "Stay calm and assess the situation.",
    "Call emergency services immediately if someone is injured.",
    "Provide first aid if you are trained to do so.",
    "Keep emergency contact numbers saved in your phone.",
    "Avoid panic and follow instructions from emergency responders.",
  ];

  EmergencyScreen({super.key});

  // Function to call an emergency number
  void _callNumber(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Contacts Section
            Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: emergencyContacts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(emergencyContacts[index]['name']!),
                    subtitle: Text(emergencyContacts[index]['number']!),
                    trailing: IconButton(
                      icon: Icon(Icons.phone),
                      onPressed: () =>
                          _callNumber(emergencyContacts[index]['number']!),
                    ),
                  ),
                );
              },
            ),

            // Health Tips Section
            SizedBox(height: 32),
            Text(
              'Health Tips',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: healthTips.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Icon(Icons.medical_services),
                    title: Text(healthTips[index]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
