import 'package:blood_donnation/config/config.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:blood_donnation/api.dart';
import 'package:blood_donnation/page/Pub/Pub.dart';

import '../Pub/PublicitesDetailsPage.dart';
import 'details.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _announcements = [];
  List<Pub> _publicites = [];
  String? _userId;
  String? _processingAnnonceId;

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
    _fetchUserProfile();
    _fetchPublicites();
  }

  Future<void> _fetchAnnouncements() async {
    try {
      final announcements = await _apiService.getAnnouncements();
      print('Fetched announcements: $announcements');
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
        _userId = profileData['id'].toString(); // Stocke l'ID de l'utilisateur connecté
      });
    } catch (e) {
      print('Erreur lors de la récupération du profil : $e');
    }
  }

  // obtenir les publicites
  Future<void> _fetchPublicites() async {
    try {
      final publicites = await _apiService.getPublicites();
      print('Fetched publicites: $publicites');
      setState(() {
        _publicites = publicites;
      });
    } catch (e) {
      print('Failed to load publicites: $e');
    }
  }


  bool _hasNewNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/Icons/Icon.png'),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/NotificationPage');
                },
                icon: Icon(Icons.notifications, color: Colors.black),
              ),
              if (_hasNewNotifications)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                    child: Center(
                      child: Text(
                        '•',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCarousel(),
              SizedBox(height: 30),
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildClickableElement(Icons.person, "Voir Mon Profil", '/ProfilePage'),
                      _buildClickableElement(Icons.add_circle_outline, "Publier Annonce", '/demande'),
                      _buildClickableElement(Icons.visibility, "Voir Annonce", '/annonce'),
                    ],
                  ),
                 
              SizedBox(height: 15),
              Text(
                "ANNONCE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
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
                    margin:  EdgeInsets.symmetric(vertical: 8.0),
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
                        subtitle: Text(
                            annonce['description'] ?? 'Aucune description'),
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClickableElement(IconData icon, String text, String routeName) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(121, 239, 19, 19),
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Column(
          children: [
            Icon(icon, size: 40, color: Color(0x80FFFFFF)),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    if (_publicites.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    const String baseUrl= ApiEndpoints.imageurl;

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: _publicites.map((publicite) {
        final imageUrl = '$baseUrl${publicite.image}';
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PubliciteDetailsPage(
              publicite: publicite,
              ),
            ),
            );

          },
          child: Container(
            child: Center(
              child: Image.network(
                imageUrl, // URL of the ad image
                fit: BoxFit.cover,
                width: 1000,
              ),
            ),
          ),
        );
      }).toList(),
    );

  }
}

