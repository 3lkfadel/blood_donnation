import 'package:flutter/material.dart';

class BloodGroupSelectionScreen extends StatefulWidget {
  @override
  _BloodGroupSelectionScreenState createState() =>
      _BloodGroupSelectionScreenState();
}

class _BloodGroupSelectionScreenState
    extends State<BloodGroupSelectionScreen> {
  String? selectedGroup;
  String? selectedRhesus;

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
                bloodGroupButton('A'),
                bloodGroupButton('B'),
                bloodGroupButton('AB'),
                bloodGroupButton('O'),
              ],
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 20,
              children: [
                rhesusButton('+'),
                rhesusButton('-'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedGroup != null && selectedRhesus != null
                  ? () {
                      Navigator.pushNamed(context, '/nav');
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                           content: Text(
                               'Groupe sélectionné : $selectedGroup, Rhésus : $selectedRhesus'),
                         ),
                       );
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
        foregroundColor: Colors.red, backgroundColor: isSelected ? Colors.red : Colors.red[100],
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

  Widget rhesusButton(String rhesus) {
    bool isSelected = selectedRhesus == rhesus;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.red, backgroundColor: isSelected ? Colors.red : Colors.red[100],
        minimumSize: Size(50, 50),
      ),
      onPressed: () {
        setState(() {
          selectedRhesus = rhesus;
        });
      },
      child: Text(
        rhesus,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.red,
          fontSize: 24,
        ),
      ),
    );
  }
}
