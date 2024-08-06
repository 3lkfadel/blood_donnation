import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart'; // Assurez-vous que le chemin d'importation est correct

class BloodGroupSelectionScreen extends StatefulWidget {
  @override
  _BloodGroupSelectionScreenState createState() => _BloodGroupSelectionScreenState();
}

class _BloodGroupSelectionScreenState extends State<BloodGroupSelectionScreen> {
  String? selectedGroup;
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sélectionner votre groupe sanguin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sélectionner votre groupe sanguin',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                bloodGroupButton('A+'),
                bloodGroupButton('B+'),
                bloodGroupButton('AB+'),
                bloodGroupButton('O+'),
                bloodGroupButton('A-'),
                bloodGroupButton('B-'),
                bloodGroupButton('AB-'),
                bloodGroupButton('O-'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedGroup != null
                  ? () async {
                await _updateBloodGroup(selectedGroup!);
              }
                  : null,
              child: Text('Continuer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget bloodGroupButton(String group) {
    bool isSelected = selectedGroup == group;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.red,
        backgroundColor: isSelected ? Colors.red : Colors.red[100],
        minimumSize: Size(80, 80),
      ),
      onPressed: () {
        setState(() {
          selectedGroup = group;
        });
      },
      child: Text(
        group,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.red,
          fontSize: 24,
        ),
      ),
    );
  }

  Future<void> _updateBloodGroup(String bloodGroup) async {
    try {
      final response = await _apiService.updateBloodGroup(bloodGroup);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Compte créée avec succès ! Bienvenue'),
          ),
        );
        Navigator.pushNamed(context, '/nav');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Échec de l\'enregistrement du groupe sanguin'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'enregistrement: $e'),
        ),
      );
    }
  }
}
