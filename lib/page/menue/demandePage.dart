import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';

class BloodDonationFormPage extends StatefulWidget {
  @override
  _BloodDonationFormPageState createState() => _BloodDonationFormPageState();
}

class _BloodDonationFormPageState extends State<BloodDonationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  String? selectedGender;
  String? _bloodType;
  String? _reason;
  String? _title;
  String? _description;
  String? _healthCenter;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }


  Future<void> _loadUserProfile() async {
    try {
      final profileData = await _apiService.getProfiles();
      setState(() {
        _nameController.text = profileData['name'] ?? '';
        _emailController.text = profileData['email'] ?? '';
        _phoneController.text = profileData['telephone'] ?? '';
        _ageController.text = profileData['age']?.toString() ?? '';
        _cityController.text = profileData['ville'] ?? '';
        selectedGender = profileData['sexe'];
      });
    } catch (e) {
      print('Failed to load user profile: $e');
      // Gérer l'erreur ou afficher un message
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Assurez-vous d'envoyer toutes les données nécessaires ici
        final response = await _apiService.postAnnouncement(
          _title!,
          _description!,
          _reason!,
          _bloodType!,
          _healthCenter!,
        );
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Annonce publiée avec succès")),
          );
          // redirer vers l'accueil
          Navigator.pushReplacementNamed(context, '/nav');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur lors de la publication de l'annonce")),
          );
        }
      } catch (e) {
        print('Failed to post announcement: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de la publication de l'annonce")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publier une annonce de demande de sang'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Numéro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre numéro de téléphone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Âge'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre âge';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(labelText: 'Sexe'),
                items: ['Homme', 'Femme', 'Autre']
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner le sexe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Ville'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre ville';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Titre de l\'annonce'),
                onSaved: (value) {
                  _title = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le titre de l\'annonce';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) {
                  _description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la description';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Centre de santé'),
                onSaved: (value) {
                  _healthCenter = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le centre de santé';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              Text('Type de sang'),
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  _buildBloodTypeChip('A+'),
                  _buildBloodTypeChip('A-'),
                  _buildBloodTypeChip('B+'),
                  _buildBloodTypeChip('B-'),
                  _buildBloodTypeChip('AB+'),
                  _buildBloodTypeChip('AB-'),
                  _buildBloodTypeChip('O+'),
                  _buildBloodTypeChip('O-'),
                ],
              ),
              SizedBox(height: 16),
              Text('Raison'),
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  _buildReasonChip('Accident'),
                  _buildReasonChip('Chirurgie'),
                  _buildReasonChip('Autre'),
                  _buildReasonChip('Grossesse'),
                  _buildReasonChip('Je préfère ne pas le dire'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBloodTypeChip(String bloodType) {
    return ChoiceChip(
      label: Text(bloodType),
      selected: _bloodType == bloodType,
      onSelected: (selected) {
        setState(() {
          _bloodType = selected ? bloodType : null;
        });
      },
    );
  }

  Widget _buildReasonChip(String reason) {
    return ChoiceChip(
      label: Text(reason),
      selected: _reason == reason,
      onSelected: (selected) {
        setState(() {
          _reason = selected ? reason : null;
        });
      },
    );
  }
}
