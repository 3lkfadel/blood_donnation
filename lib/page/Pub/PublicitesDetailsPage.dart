import 'package:blood_donnation/config/config.dart';
import 'package:flutter/material.dart';

import 'Pub.dart';

class PubliciteDetailsPage extends StatelessWidget {
  final Pub publicite;

  PubliciteDetailsPage({required this.publicite});
  static const String baseUrl = ApiEndpoints.imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(publicite.libelle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    '${baseUrl}${publicite.image}', // URL of the ad image
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250, // Ajuster la hauteur selon vos besoins
                  ),
                  Container(
                    width: double.infinity,
                    height: 250, // Doit correspondre à la hauteur de l'image
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6), // Couleur sombre
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                publicite.libelle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                publicite.contenu,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
