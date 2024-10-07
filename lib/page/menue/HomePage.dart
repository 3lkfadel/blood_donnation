import 'package:blood_donnation/config/config.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:blood_donnation/api.dart';
import 'package:blood_donnation/page/Pub/Pub.dart';

import '../../config/Notification.dart';
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
  bool _hasNewNotifications = true;
  int _unreadNotificationCount=0; // Store the count of unread notifications

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
    _fetchUserProfile();
    _fetchPublicites();
    _checkNewNotifications();
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
        _userId = profileData['id'].toString();
      });
    } catch (e) {
      print('Erreur lors de la récupération du profil : $e');
    }
  }

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

  Future<void> _refreshData() async {
    await _fetchAnnouncements();
    await _fetchPublicites();
    await _fetchUserProfile();
    await _checkNewNotifications();
  }

  Future<void> _checkNewNotifications() async {
    try {
      // Récupérez les notifications depuis l'API, qui renvoie déjà une liste d'objets AppNotification
      final notifications = await _apiService.getNotifications();

      // Assurez-vous que notifications est bien une List<AppNotification>
      if (notifications is List<AppNotification>) {
        setState(() {
          _unreadNotificationCount = notifications
              .where((notification) => !notification.isRead)
              .length;
          _hasNewNotifications = _unreadNotificationCount > 0;
        });
      } else {
        // Gérer le cas où les données ne sont pas de type List<AppNotification>
        print('Les données des notifications ne sont pas au format attendu.');
      }
    } catch (e) {
      print('Erreur lors de la vérification des notifications : $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.white,
        elevation: 1,
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '$_unreadNotificationCount',
                        // Display unread notification count
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCarousel(),
                SizedBox(height: 30),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildClickableElement(
                        Icons.person, "Voir Mon Profil", '/ProfilePage'),
                    _buildClickableElement(
                        Icons.add_circle_outline, "Publier Annonce",
                        '/demande'),
                    _buildClickableElement(
                        Icons.visibility, "Voir Annonce", '/annonce'),
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
                    final isProcessing = _processingAnnonceId ==
                        annonce['id'].toString();

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
                        subtitle: Text(annonce['description'] ??
                            'Aucune description'),
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
                                        _processingAnnonceId =
                                            annonce['id'].toString();
                                      });

                                      try {
                                        await _apiService.createDon(
                                            annonce['id'], _userId!);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Demande envoyée avec succès.'),
                                          ),
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Details(
                                                    annonceId: annonce['id']),
                                          ),
                                        );
                                      } catch (e) {
                                        print('Erreur: $e');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                      : Text(
                                      isAuthor ? "Voir Détails" : "Répondre"),
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
      ),
    );
  }

  Widget _buildClickableElement(IconData icon, String text, String routeName) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.0),
      padding: EdgeInsets.all(10.0),
      // Augmenter le padding pour une meilleure apparence
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
          mainAxisAlignment: MainAxisAlignment.center,
          // Centrer le contenu verticalement
          children: [
            Icon(icon, size: 40, color: Color(0x80FFFFFF)),
            SizedBox(height: 5), // Utiliser SizedBox pour l'espacement vertical
            Text(
              text,
              textAlign: TextAlign.center, // Centrer le texte horizontalement
              style: TextStyle(
                fontSize: 14,
                // Augmenter la taille de la police pour une meilleure lisibilité
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
    const String baseUrl = ApiEndpoints.imageurl;

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        // Hauteur fixe pour toutes les images
        autoPlay: true,
        enlargeCenterPage: false,
        // Désactiver l'agrandissement pour éviter de voir les images suivantes
        aspectRatio: 16 / 9,
        viewportFraction: 1.0, // Afficher une image complète à la fois
      ),
      items: _publicites.map((publicite) {
        final imageUrl = '$baseUrl${publicite.image}';
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PubliciteDetailsPage(
                      publicite: publicite,
                    ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            // Espace entre les images
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              // Arrondir les bords des images
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Couleur de l'ombre
                      blurRadius: 8, // Flou de l'ombre
                      offset: Offset(0, 4), // Décalage de l'ombre
                    ),
                  ],
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  // Assure que l'image remplisse le conteneur
                  width: double
                      .infinity, // Largeur maximale pour occuper tout l'espace disponible
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
