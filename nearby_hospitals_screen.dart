import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import 'mongodb_service.dart';
import 'hospital_card.dart';

class NearbyHospitalsScreen extends StatefulWidget {
  const NearbyHospitalsScreen({super.key});

  @override
  State<NearbyHospitalsScreen> createState() => _NearbyHospitalsScreenState();
}

class _NearbyHospitalsScreenState extends State<NearbyHospitalsScreen> {
  List<Map<String, dynamic>> hospitals = [];
  bool isLoading = false;
  final LocationService locationService = LocationService();
  final MongoDBService mongoDBService = MongoDBService();

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    setState(() {
      isLoading = true;
    });

    try {
      Position position = await locationService.getCurrentLocation();
      hospitals = await mongoDBService.fetchNearbyHospitals(
        position.latitude,
        position.longitude,
        10,
      );
    } catch (e) {
      ('Error fetching hospitals: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Hospitals'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hospitals.isEmpty
          ? const Center(child: Text('No hospitals found nearby'))
          : ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          return HospitalCard(
            name: hospital['name'] ?? 'Unknown Hospital',
            address: hospital['address'] ?? 'No Address',
            contactNumber: hospital['contact'] ?? 'N/A',
          );
        },
      ),
    );
  }
}

