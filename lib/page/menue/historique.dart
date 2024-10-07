import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';
import 'UserDons.dart';

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _demandes = [];
  List<Map<String, dynamic>> _filteredDemandes = [];
  List<Map<String, dynamic>> _donsEffectues = [];
  bool _isLoadingDemandes = false;
  bool _isLoadingDons = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _fetchUserDons();
    _searchController.addListener(
        _filterDemandes); // Listen for changes in the search bar
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
        _filteredDemandes = annonces; // Initialize the filtered list
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

  void _filterDemandes() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDemandes = _demandes.where((demande) {
        return (demande['titre']?.toLowerCase().contains(query) ?? false) ||
            (demande['description']?.toLowerCase().contains(query) ?? false);
      }).toList();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _searchController.dispose(); // Dispose the search controller
    super.dispose();
  }

  Future<void> _fetchDonsForAnnonce(int annonceId) async {
    try {
      final dons = await ApiService().getDonsForAnnonce(annonceId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UserDons(
                dons: dons,
                annonceId: annonceId,
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
          RefreshIndicator(
            onRefresh: _fetchUserDons,
            child: _isLoadingDons
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Column(
                children: _donsEffectues.map((don) {
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                          'Demandeur: ${don['annonce']['user']['name']}'),
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
          ),
          RefreshIndicator(
            onRefresh: _fetchUserDemandes,
            child: _isLoadingDemandes
                ? Center(child: CircularProgressIndicator())
                : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Rechercher des demandes',
                      border: InputBorder.none,
                      // No border
                      filled: true,
                      // Optional: fill the background
                      fillColor: Colors.grey[200],
                      // Optional: set a background color
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: _filteredDemandes.map((demande) {
                        final isInactive = demande['etat'] == 'fermé';
                        return GestureDetector(
                          onTap: isInactive
                              ? null
                              : () async {
                            await _fetchDonsForAnnonce(demande['id']);
                          },
                          child: Stack(
                            children: [
                              Card(
                                margin: EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(demande['titre'] ?? 'Sans titre'),
                                  subtitle: Text(demande['description'] ??
                                      'Aucune description'),
                                  trailing: Text(demande['created_at'] ?? ''),
                                ),
                              ),
                              if (isInactive)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Annonce fermée',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
