import 'package:google_maps_flutter/google_maps_flutter.dart';

class Clinic {
  final String id;
  final String name;
  final LatLng location;
  final String phone;
  final List<String> services;

  Clinic({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
    required this.services,
  });
}
