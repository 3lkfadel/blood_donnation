import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:blood_donnation/api.dart';
import 'centreSante.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _initialPosition = LatLng(12.3612, -1.5167);
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _loadHealthCenters();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      await Permission.locationWhenInUse.request();
    }
  }

  Future<void> _loadHealthCenters() async {
    try {
      List<HealthCenter> centers = await _apiService.fetchHealthCenters();
      setState(() {
        for (var center in centers) {
          _markers.add(
            Marker(
              markerId: MarkerId(center.id.toString()),
              position: LatLng(center.latitude, center.longitude),
              infoWindow: InfoWindow(title: center.name),
            ),
          );
        }
      });
    } catch (e) {
      print('Erreur lors du chargement des centres : $e');
    }
  }
  void _searchAndNavigate() {
    String searchQuery = _searchController.text.toLowerCase();

    // Rechercher un centre dont le nom contient le texte saisi
    Marker? marker = _markers.firstWhere(
          (marker) => marker.infoWindow.title!.toLowerCase().contains(searchQuery),
      orElse: () => Marker(markerId: MarkerId('')),
    );

    // Si un centre est trouvé, déplacer la caméra sur celui-ci
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
      // Afficher un message si aucun centre n'est trouvé
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Centre non trouvé')),
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
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
              ),
            ],
          ),
          child:_buildSearchField(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 30),
            onPressed: _searchAndNavigate,
          ),
        ],
        backgroundColor: Colors.redAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition, // Centré sur Ouagadougou
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

  Widget _buildSearchField() {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return _markers
            .map((marker) => marker.infoWindow.title!)
            .where((title) => title.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        _searchController.text = selection;
        _searchAndNavigate();
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Rechercher un point',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: TextStyle(color: Colors.black, fontSize: 18.0),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            _searchAndNavigate();
          },
        );
      },
    );
  }

}


