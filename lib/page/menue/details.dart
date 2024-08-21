import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';
import 'package:blood_donnation/config/config.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  final int? notificationId;
  final int? annonceId;

  const Details({super.key, this.notificationId, this.annonceId});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Future<Map<String, dynamic>> _announcementFuture;

  @override
  void initState() {
    super.initState();
    if (widget.annonceId != null) {
      _announcementFuture = ApiService().getAnnouncementDetails(widget.annonceId!);
    } else if (widget.notificationId != null) {
      _announcementFuture = ApiService().getAnnonceByNotification(widget.notificationId!);
    }
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossible de passer l'appel")),
      );
    }
  }

  Future<void> _sendMessage(String phoneNumber) async {
    final Uri url = Uri.parse('sms:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossible d'envoyer le message")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 218, 56, 27),
        title: Text(
          'Détails de l\'Annonce',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _announcementFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Aucune donnée disponible.'));
          } else {
            final announcement = snapshot.data!;
            final annonce = announcement['annonce'] ?? {};
            final user = announcement['user'] ?? {};
            final userName = '${user['name']}';
            const String baseurl = ApiEndpoints.imageurl;
            final userPhotoUrl = user['image'] as String?;
            final userPhoneNumber = user['telephone'] ?? '';

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Photo and Name
                    Wrap(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: userPhotoUrl != null && userPhotoUrl.isNotEmpty
                              ? NetworkImage('$baseurl$userPhotoUrl')
                              : AssetImage("assets/placeholder.png") as ImageProvider,
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName.isNotEmpty ? userName : 'Indisponible',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Email: ${user['email'] ?? 'Indisponible'}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Téléphone: $userPhoneNumber',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Announcement Details
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Annonce:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            annonce['titre'] ?? 'Indisponible',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Informations de la demande:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Groupe Sanguin: ${annonce['TypeSang'] ?? 'Indisponible'}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Centre de Santé: ${annonce['CentreSante'] ?? 'Indisponible'}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Description: ${annonce['description'] ?? 'Indisponible'}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Raison: ${annonce['raison'] ?? 'Indisponible'}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    // Action Buttons
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _makePhoneCall(userPhoneNumber),
                      child: Text('Appeler'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Color.fromARGB(255, 218, 56, 27),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 16), // Espace entre les deux boutons
                    ElevatedButton(
                      onPressed: () => _sendMessage(userPhoneNumber),
                      child: Text('Message'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Colors.blue,
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),

                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
