import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email and password
  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  // Fetch clinics from Firestore
  Stream<QuerySnapshot> getClinics() {
    return _firestore.collection('clinics').snapshots();
  }

  // Fetch doctors from Firestore
  Stream<QuerySnapshot> getDoctors() {
    return _firestore.collection('doctors').snapshots();
  }

  // Fetch blood donation campaigns from Firestore
  Stream<QuerySnapshot> getBloodDonationCampaigns() {
    return _firestore.collection('blood_donation_campaigns').snapshots();
  }

  // Book a telemedicine appointment
  Future<void> bookAppointment(String doctorId, String date, String time) async {
    try {
      await _firestore.collection('appointments').add({
        'userId': currentUser?.uid,
        'doctorId': doctorId,
        'date': date,
        'time': time,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to book appointment: $e');
    }
  }
}