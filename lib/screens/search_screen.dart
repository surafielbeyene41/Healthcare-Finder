import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare_finder/models/clinic.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late GoogleMapController mapController;
  LatLng? _currentLocation;
  final Set<Marker> _markers = {};
  final List<Clinic> _clinics = [];
  List<Clinic> _filteredClinics = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchClinics();
    _searchController.addListener(_filterClinics);
    Timer.periodic(Duration(seconds: 10), (Timer t) => _updateUserLocation()); // Update location every 10 seconds
  }

  /// Get user's current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  /// Update user's current location periodically
  void _updateUserLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  /// Fetch clinics from Firestore
  Future<void> _fetchClinics() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('clinics').get();

      List<Clinic> clinics = snapshot.docs.map((doc) {
        final data = doc.data();
        return Clinic(
          id: doc.id,
          name: data['name'],
          location: LatLng(
            data['location']['lat'],
            data['location']['lng'],
          ),
          phone: data['phone'],
          services: List<String>.from(data['services']),
        );
      }).toList();

      setState(() {
        _clinics.clear();
        _clinics.addAll(clinics);
        _filteredClinics = List.from(_clinics); // Initialize with all clinics
        _markers.clear();
        _addMarkers(clinics);
        _sortClinicsByDistance(); // Sort clinics by proximity
      });
    } catch (e) {
      print('Error fetching clinics: $e');
    }
  }

  /// Add markers to the map
  void _addMarkers(List<Clinic> clinics) {
    for (var clinic in clinics) {
      _markers.add(
        Marker(
          markerId: MarkerId(clinic.id),
          position: clinic.location,
          infoWindow: InfoWindow(
            title: clinic.name,
            snippet: clinic.phone,
          ),
        ),
      );
    }
  }

  /// Filter clinics based on search query
  void _filterClinics() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredClinics = _clinics.where((clinic) {
        return clinic.name.toLowerCase().contains(query) || clinic.services.any((service) => service.toLowerCase().contains(query));
      }).toList();
    });
  }

  /// Sort clinics by distance from the user's current location
  void _sortClinicsByDistance() {
    if (_currentLocation != null) {
      _clinics.sort((a, b) {
        double distanceA = _calculateDistance(a.location, _currentLocation!);
        double distanceB = _calculateDistance(b.location, _currentLocation!);
        return distanceA.compareTo(distanceB);
      });
    }
  }

  /// Calculate distance between two LatLng points
  double _calculateDistance(LatLng start, LatLng end) {
    var distanceInMeters = Geolocator.distanceBetween(start.latitude, start.longitude, end.latitude, end.longitude);
    return distanceInMeters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Clinics'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Clinics',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          // Google Map
          Expanded(
            flex: 2,
            child: _currentLocation == null
                ? Center(child: CircularProgressIndicator())
                : GoogleMap(
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 12.0,
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
          ),

          // List of Clinics
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _filteredClinics.isEmpty ? _clinics.length : _filteredClinics.length,
              itemBuilder: (context, index) {
                var clinic = _filteredClinics.isEmpty ? _clinics[index] : _filteredClinics[index];
                return ListTile(
                  title: Text(clinic.name),
                  subtitle: Text(clinic.phone),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClinicDetailsScreen(clinic: clinic),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClinicDetailsScreen extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetailsScreen({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clinic.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Phone: ${clinic.phone}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Services:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...clinic.services.map((service) => Text(service, style: TextStyle(fontSize: 14))),
          ],
        ),
      ),
    );
  }
}
