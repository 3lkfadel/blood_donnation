import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);

  // Ajout d'un marqueur
  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('_pGooglePlex'),
      position: _pGooglePlex,
      infoWindow: InfoWindow(title: 'Google Plex'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
      ),
    );
  }
}
