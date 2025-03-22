import 'package:flutter/material.dart';
import 'package:healthcare_finder/models/doctor.dart';
import 'package:healthcare_finder/widgets/doctor_card.dart';

class TelemedicineScreen extends StatefulWidget {
  const TelemedicineScreen({super.key});

  @override
  _TelemedicineScreenState createState() => _TelemedicineScreenState();
}

class _TelemedicineScreenState extends State<TelemedicineScreen> {
  final List<Doctor> _doctors = []; // List of doctors fetched from Firestore

  @override
  void initState() {
    super.initState();
    _fetchDoctors(); // Fetch doctors from Firestore
  }

  // Fetch doctors from Firestore (mock data for now)
  Future<void> _fetchDoctors() async {
    // Replace this with actual Firestore data fetching
    List<Doctor> doctors = [
      Doctor(
        id: '1',
        name: 'Dr. John Doe',
        specialty: 'General Physician',
        availableSlots: ['10:00 AM', '2:00 PM', '4:00 PM'],
      ),
      Doctor(
        id: '2',
        name: 'Dr. Jane Smith',
        specialty: 'Pediatrician',
        availableSlots: ['9:00 AM', '1:00 PM', '3:00 PM'],
      ),
      Doctor(
        id: '3',
        name: 'Dr. Michael Brown',
        specialty: 'Cardiologist',
        availableSlots: ['11:00 AM', '3:00 PM', '5:00 PM'],
      ),
    ];

    setState(() {
      _doctors.addAll(doctors);
    });
  }

  // Book an appointment with a doctor
  void _bookAppointment(Doctor doctor, String slot) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Appointment'),
          content: Text(
              'Are you sure you want to book an appointment with ${doctor.name} at $slot?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Save the appointment to Firestore
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Appointment booked successfully!'),
                  ),
                );
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telemedicine'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(
            doctor: _doctors[index],
            onBookAppointment: _bookAppointment,
          );
        },
      ),
    );
  }
}