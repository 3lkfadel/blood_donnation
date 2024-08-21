import 'package:flutter/material.dart';

import 'Pub.dart';
class PubliciteDetailsPage extends StatelessWidget {
  final Pub publicite;

  PubliciteDetailsPage({required this.publicite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(publicite.libelle),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              publicite.image, // URL of the ad image
              fit: BoxFit.cover,
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
    );
  }
}