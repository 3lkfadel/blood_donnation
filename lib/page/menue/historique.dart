import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _demandes = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchUserDemandes();
  }

  Future<void> _fetchUserDemandes() async {
    try {
      final annonces = await ApiService().getAnnoncesHistory();
      setState(() {
        _demandes = annonces;
      });
    } catch (e) {
      print('Failed to load user demandes: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            Tab(text: 'Don effectué'),
            Tab(text: 'Demande effectuée'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text("Contenu des dons ici"),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: _demandes.map((demande) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
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
