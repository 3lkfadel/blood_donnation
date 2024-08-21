import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';
import 'details.dart';

class Annoncepage extends StatefulWidget {
  Annoncepage({super.key});

  @override
  State<Annoncepage> createState() => _AnnoncepageState();
}

class _AnnoncepageState extends State<Annoncepage> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _announcements = [];
  String? _userId;
  String? _processingAnnonceId; // Variable pour stocker l'ID de l'annonce en cours de traitement

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
    _fetchUserProfile();
  }

  Future<void> _fetchAnnouncements() async {
    try {
      final announcements = await _apiService.getAnnouncements();
      setState(() {
        _announcements = announcements;
      });
    } catch (e) {
      print('Failed to load announcements: $e');
    }
  }

  Future<void> _fetchUserProfile() async {
    try {
      final profileData = await _apiService.getProfiles();
      setState(() {
        _userId = profileData['id'].toString();
      });
    } catch (e) {
      print('Erreur lors de la récupération du profil : $e');
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
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/demande');
                  },
                  icon: Icon(Icons.bloodtype),
                  label: Text('Besoin de sang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.all(19),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  icon: Icon(Icons.favorite),
                  label: Text('Centre de don'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.all(19),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          _announcements.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _announcements.length,
            itemBuilder: (context, index) {
              final annonce = _announcements[index];
              final isProcessing = _processingAnnonceId == annonce['id'].toString();

              return Card(
                color: Colors.red[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Text(
                    annonce['TypeSang'] ?? 'N/A',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(annonce['titre'] ?? 'Sans titre'),
                  subtitle: Text(annonce['description'] ?? 'Aucune description'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: isProcessing
                            ? null
                            : () async {
                          setState(() {
                            _processingAnnonceId = annonce['id'].toString();
                          });

                          try {
                            await _apiService.createDon(
                                annonce['id'], _userId!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Demande envoyée avec succès.'),
                              ),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Details(annonceId: annonce['id']),
                              ),
                            );
                          } catch (e) {
                            print('Erreur: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Erreur lors de l\'envoi de la demande.'),
                              ),
                            );
                          } finally {
                            setState(() {
                              _processingAnnonceId = null;
                            });
                          }
                        },
                        child: isProcessing
                            ? CircularProgressIndicator()
                            : Text("Répondre"),
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
