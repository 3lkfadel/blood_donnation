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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'DET',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'AILS',
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

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: userPhotoUrl != null && userPhotoUrl.isNotEmpty
                          ? NetworkImage('$baseurl$userPhotoUrl')
                          : AssetImage("assetName") as ImageProvider,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Nom et Prénom:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      userName.isNotEmpty ? userName : 'Indisponible',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      children: [
                        Text(
                          'Email : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          user['email'] ?? '',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      children: [
                        Text(
                          'Numero de téléphone : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          userPhoneNumber,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
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
                      'Information de demande:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Groupe Sanguin : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          annonce['TypeSang'] ?? '',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      children: [
                        Text(
                          'Centre de santé : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          annonce['CentreSante'] ?? '',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      children: [
                        Text(
                          'Description : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          annonce['description'] ?? 'Description indisponible',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Raison : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          annonce['raison'] ?? '',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _makePhoneCall(userPhoneNumber),
                        child: Text('Appelle'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _sendMessage(userPhoneNumber),
                        child: Text('Message'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
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
