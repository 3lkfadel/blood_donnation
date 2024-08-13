import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';

class Annoncepage extends StatefulWidget {
  Annoncepage({super.key});

  @override
  State<Annoncepage> createState() => _AnnoncepageState();
}

class _AnnoncepageState extends State<Annoncepage> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _announcements = [];

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
  }

  Future<void> _fetchAnnouncements() async {
    try {
      final announcements = await _apiService.getAnnouncements();
      print('Fetched announcements: $announcements'); // Ajoutez ceci pour déboguer
      setState(() {
        _announcements = announcements;
      });
    } catch (e) {
      print('Failed to load announcements: $e');
      // Vous pouvez afficher un message d'erreur ici
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
                    text: 'TI',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'TLE',
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/NotificationPage');
            },
            icon: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
        automaticallyImplyLeading: false, 
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,

              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/demande');
                  },
                  icon: Icon(Icons.bloodtype),
                  label: Text('Besoin de sang'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red,
                      padding: EdgeInsets.all(19)
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                  label: Text('Centre de don'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey,
                  padding: EdgeInsets.all(19)
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          _announcements.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            shrinkWrap: true, // Permet de redimensionner la hauteur du ListView
            physics: NeverScrollableScrollPhysics(), // Empêche le défilement du ListView interne
            itemCount: _announcements.length,
            itemBuilder: (context, index) {
              final annonce = _announcements[index];
              return Card(
                color: Colors.red[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Text(
                    annonce['TypeSang'] ?? 'N/A',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  title: Text(annonce['titre'] ?? 'Sans titre'),
                  subtitle: Text(annonce['description'] ?? 'Aucune description'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(onPressed: (){}, child: Text("Répondre")),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}
