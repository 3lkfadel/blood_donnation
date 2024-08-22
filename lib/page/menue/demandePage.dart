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
  String? _selectedHealthCenter;
  List<Map<String, dynamic>> _healthCenters = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadHealthCenters();
  }

  Future<void> _loadHealthCenters() async {
    try {
      final centers = await _apiService.getCentresSante();
      setState(() {
        _healthCenters = centers;
      });
    } catch (e) {
      print('Failed to load health centers: $e');
    }
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
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final response = await _apiService.postAnnouncement(
          _title!,
          _description!,
          _reason!,
          _bloodType!,
          _selectedHealthCenter!,
        );
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Annonce publiée avec succès")),
          );
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
        backgroundColor: Color(0xFFF9888E),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildUserInfoContainer(),
              SizedBox(height: 16),
              _buildFormContainer(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Soumettre'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFF9888E)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildUserInfoRow('Nom:', _nameController.text),
          _buildUserInfoRow('Numéro:', _phoneController.text),
          _buildUserInfoRow('Âge:', _ageController.text),
          _buildUserInfoRow('Email:', _emailController.text),
          _buildUserInfoRow('Ville:', _cityController.text),
          _buildUserInfoRow('Sexe:', selectedGender ?? ''),
        ],
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildFormContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.lightBlue[200]!),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
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
          SizedBox(height: 16),
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
          SizedBox(height: 16),
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return _healthCenters
                  .map((center) => center['nom'].toString())
                  .where((nom) => nom.toLowerCase().contains(textEditingValue.text.toLowerCase()));
            },
            onSelected: (String selection) {
              setState(() {
                _selectedHealthCenter = selection;
              });
            },
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: 'Centre de santé',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedHealthCenter = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner ou entrer un centre de santé';
                  }
                  return null;
                },
              );
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
        ],
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
