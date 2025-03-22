import 'package:flutter/material.dart';
import 'package:healthcare_finder/models/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final Function(Doctor, String) onBookAppointment;

  const DoctorCard({super.key, 
    required this.doctor,
    required this.onBookAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Specialty: ${doctor.specialty}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Available Slots:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 8,
              children: doctor.availableSlots.map((slot) {
                return ElevatedButton(
                  onPressed: () {
                    onBookAppointment(doctor, slot);
                  },
                  child: Text(slot),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}