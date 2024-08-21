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
  List<Map<String, dynamic>> _donsEffectues = [];
  bool _isLoadingDemandes = false;
  bool _isLoadingDons = false;
  bool _isFetchingDons = false; // Pour empêcher les clics multiples

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
    if (_isFetchingDons) return; // Empêcher les clics multiples

    setState(() {
      _isFetchingDons = true;
    });

    try {
      final dons = await ApiService().getDonsForAnnonce(annonceId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDons(
            dons: dons,
            annonceId: annonceId,
          ),
        ),
      );
    } catch (e) {
      print('Failed to load dons: $e');
    } finally {
      setState(() {
        _isFetchingDons = false;
      });
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
            child: Column(
              children: _demandes.map((demande) {
                bool isClosed = demande['etat'] == 'inactif';
                return GestureDetector(
                  onTap: _isFetchingDons
                      ? null
                      : () async {
                    await _fetchDonsForAnnonce(demande['id']);
                  },
                  child: Stack(
                    children: [
                      Card(
                        margin: EdgeInsets.all(8.0),
                        elevation: 4,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeInOut,
                          color: _isFetchingDons ? Colors.grey[50] : Colors.grey[50],
                          child: ListTile(
                            title: Text(demande['titre'] ?? 'Sans titre'),
                            subtitle: Text(demande['description'] ?? 'Aucune description'),
                            trailing: Text(demande['created_at'] ?? ''),
                          ),
                        ),
                      ),
                      if (isClosed)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Text(
                                'Annonce fermée',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
        ],
      ),
    );
  }
}
