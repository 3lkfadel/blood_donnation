import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';

import 'UserDons.dart'; // Import your UserDons page

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _demandes = [];
  List<Map<String, dynamic>> _donsEffectues = [];
  bool _isLoadingDemandes = false;
  bool _isLoadingDons = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _fetchUserDons(); // Charger les dons par défaut
  }

  void _handleTabSelection() {
    if (_tabController.index == 0 && _donsEffectues.isEmpty) {
      _fetchUserDons();
    } else if (_tabController.index == 1 && _demandes.isEmpty) {
      _fetchUserDemandes();
    }
  }

  Future<void> _fetchUserDemandes() async {
    setState(() {
      _isLoadingDemandes = true;
    });
    try {
      final annonces = await ApiService().getAnnoncesHistory();
      setState(() {
        _demandes = annonces;
      });
    } catch (e) {
      print('Failed to load user demandes: $e');
    } finally {
      setState(() {
        _isLoadingDemandes = false;
      });
    }
  }

  Future<void> _fetchUserDons() async {
    setState(() {
      _isLoadingDons = true;
    });
    try {
      final dons = await ApiService().getConfirmedDons();
      setState(() {
        _donsEffectues = dons;
      });
    } catch (e) {
      print('Failed to load user dons: $e');
    } finally {
      setState(() {
        _isLoadingDons = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchDonsForAnnonce(int annonceId) async {
    try {
      final dons = await ApiService().getDonsForAnnonce(annonceId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDons(
            dons: dons,
            annonceId: annonceId, // Pass the annonce ID
          ),
        ),
      );
    } catch (e) {
      print('Failed to load dons: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'HISTO',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'TRIQUE',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Dons effectués'),
            Tab(text: 'Demandes effectuées'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _isLoadingDons
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: _donsEffectues.map((don) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Demandeur: ${don['annonce']['user']['name']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('État: ${don['etat']}'),
                      ],
                    ),
                    trailing: Text(don['created_at'] ?? ''),
                  ),
                );
              }).toList(),
            ),
          ),
          _isLoadingDemandes
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: _demandes.map((demande) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        await _fetchDonsForAnnonce(demande['id']);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close),
                          SizedBox(height: 4),
                          Text(
                            'Fermer',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    title: Text(demande['titre'] ?? 'Sans titre'),
                    subtitle: Text(demande['description'] ?? 'Aucune description'),
                    trailing: Text(demande['created_at'] ?? ''),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}