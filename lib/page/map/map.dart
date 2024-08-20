import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('_pGooglePlex'),
      position: _pGooglePlex,
      infoWindow: InfoWindow(title: 'Google Plex'),
    ),
  };

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      if (await Permission.locationWhenInUse.request().isGranted) {
        // Permission granted
      } else {
        // Permission denied
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carte avec Points')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
        markers: _markers,
        myLocationEnabled: true, // Afficher la position actuelle de l'utilisateur si permission accordée
      ),
    );
  }
}
