import 'package:flutter/material.dart';
import 'package:healthcare_finder/models/clinic.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({super.key, required this.clinic});

  void _makeCall(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not call $phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        title: Text(clinic.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(clinic.services.join(', ')),
        trailing: IconButton(
          icon: Icon(Icons.phone, color: Colors.green),
          onPressed: () => _makeCall(clinic.phone),
        ),
      ),
    );
  }
}
