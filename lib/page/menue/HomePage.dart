import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:blood_donnation/api.dart';

import 'details.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _announcements = [];
  final List<String> imgList = [
    "assets/learningpage/image3.png",
    "assets/learningpage/image2.png",
    "assets/learningpage/image3.png",
  ];
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
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: imgList.map((item) => Container(
                  child: Center(
                    child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                  ),
                )).toList(),
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildClickableElement(Icons.person, "Voir Mon Profil", '/ProfilePage'),
                    _buildClickableElement(Icons.add_circle_outline, "Publier Annonce", '/demande'),
                    _buildClickableElement(Icons.visibility, "Voir Annonce", '/annonce'),
                  ],
                ),
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
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
}
