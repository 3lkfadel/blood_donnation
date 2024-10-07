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
  String? _processingAnnonceId;

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
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'ANN',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'ONCE',
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

        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchAnnouncements,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 10.0, // Spacing between buttons
                runSpacing: 10.0, // Spacing between rows
                children: [
                  SizedBox(
                    width: 150, // Adjust the width of buttons
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/demande');
                      },
                      icon: Icon(
                        Icons.bloodtype,
                        color: Colors.white,
                        size: 20, // Adjust icon size
                      ),
                      label: Text(
                        'Besoin de sang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14, // Adjust text size
                          overflow: TextOverflow.ellipsis, // Ensure text fits
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[200],
                          padding: EdgeInsets.symmetric(vertical: 10)),
                    ),
                  ),
                  SizedBox(
                    width: 150, // Adjust the width of buttons
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/map');
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 20, // Adjust icon size
                      ),
                      label: Text(
                        'Centre de don',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14, // Adjust text size
                          overflow: TextOverflow.ellipsis, // Ensure text fits
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[200],
                          padding: EdgeInsets.symmetric(vertical: 10)),
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

                // Vérifier si l'utilisateur est l'auteur de l'annonce
                final isAuthor = _userId == annonce['user_id'].toString();

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  shadowColor: Colors.black,
                  child: ListTile(
                    leading: Text(
                      annonce['TypeSang'] ?? 'N/A',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    title: Text(annonce['titre'] ?? 'Sans titre'),
                    subtitle: Text(annonce['description'] ?? 'Aucune description'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: isProcessing
                                  ? null
                                  : () async {
                                if (isAuthor) {
                                  // Si l'utilisateur est l'auteur, afficher les détails
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Details(annonceId: annonce['id']),
                                    ),
                                  );
                                } else {
                                  // Si ce n'est pas l'auteur, créer un don
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
                                }
                              },
                              child: isProcessing
                                  ? CircularProgressIndicator()
                                  : Text(isAuthor ? "Voir Détails" : "Répondre"),
                            ),
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
      ),
      backgroundColor: Colors.white,
    );
  }
}
