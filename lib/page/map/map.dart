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
    Marker(
      markerId: MarkerId('8G59+R3'),
      position: LatLng(12.3612, -1.5167), // Coordonnées de Ouagadougou
      infoWindow: InfoWindow(title: 'Ouagadougou'),
    ),
  };

  GoogleMapController? _mapController;
  TextEditingController _searchController = TextEditingController();

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

  void _searchAndNavigate() {
    String searchQuery = _searchController.text.toLowerCase();
    Marker? marker = _markers.firstWhere(
      (marker) => marker.infoWindow.title!.toLowerCase() == searchQuery,
      orElse: () => Marker(markerId: MarkerId('')),
    );

    if (marker.markerId.value.isNotEmpty && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: marker.position,
            zoom: 15,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Point non trouvé')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              color: Colors.grey, 
              width: 2.0, 
            ),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher un point',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              hintStyle: TextStyle(color: Colors.grey),
            ),
            style: TextStyle(color: Colors.black, fontSize: 18.0),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              _searchAndNavigate();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchAndNavigate,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        myLocationEnabled: true,
      ),
    );
  }
}
