import 'dart:io';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blood_donnation/api.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  String? selectedGender;
  String? selectedCountry;
  XFile? _localImage; // Pour les images locales
  String? _networkImageUrl; // Pour les images du réseau

  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    try {
      final profileData = await _apiService.getProfiles();
      print('Profile data: $profileData');

      setState(() {
        _nameController.text = profileData['name'] ?? '';
        _phoneController.text = profileData['telephone'] ?? '';
        _ageController.text = profileData['age']?.toString() ?? '';
        _emailController.text = profileData['email'] ?? '';
        _cityController.text = profileData['ville'] ?? '';
        selectedGender = profileData['sexe'];
        selectedCountry = profileData['pays'];

        if (profileData['image'] != null) {
          _networkImageUrl = profileData['image'];
          print('Network Image URL: $_networkImageUrl');
        }
      });
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _localImage = pickedFile;
      _networkImageUrl = null; // Réinitialiser lorsque l'utilisateur choisit une nouvelle image
      print('Local Image Path: ${_localImage?.path}');
    });
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await _apiService.updateProfile(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          imagePath: _localImage?.path, // Envoi du chemin de l'image locale
          gender: selectedGender,
          ville: _cityController.text,
          age: _ageController.text,
          pays: selectedCountry,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profil mis à jour avec succès')),
          );
        }
        else if (response.statusCode == 302) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Rédirection detecté')),
          );
        }else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: ${response.data['message']}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _localImage != null
                        ? FileImage(File(_localImage!.path))
                        : (_networkImageUrl != null
                        ? NetworkImage(_networkImageUrl!)
                        : AssetImage('assets/images/Utilisateur1.jpg') as ImageProvider),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _nameController.text.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(_emailController.text),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Numero'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'email necessaire';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'Ville'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrer votre ville';
                    }
                    return null;
                  },
                ),
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
                      return 'selectionner le sexe';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Pays',
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        setState(() {
                          selectedCountry = country.name;
                        });
                      },
                    );
                  },
                  controller: TextEditingController(
                    text: selectedCountry,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'selectionner un pays';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _updateProfile,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
