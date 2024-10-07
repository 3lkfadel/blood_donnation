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
  XFile? _localImage; // For local images
  String? _networkImageUrl; // For network images

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
      _networkImageUrl = null; // Reset when a new image is selected
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
          imagePath: _localImage?.path, // Send the local image path
          gender: selectedGender,
          ville: _cityController.text,
          age: _ageController.text,
          pays: selectedCountry,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profil mis à jour avec succès')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Échec de la mise à jour : ${response.data['message']}')),
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
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('Profil',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        elevation: 0,
        backgroundColor: Colors.redAccent,
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
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _localImage != null
                        ? FileImage(File(_localImage!.path))
                        : (_networkImageUrl != null
                        ? NetworkImage(_networkImageUrl!)
                        : AssetImage('assets/images/Utilisateur1.jpg') as ImageProvider),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _nameController.text.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _emailController.text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(_nameController, 'Nom'),
                const SizedBox(height: 16),
                _buildTextField(_phoneController, 'Numéro'),
                const SizedBox(height: 16),
                _buildTextField(_ageController, 'Âge'),
                const SizedBox(height: 16),
                _buildTextField(_emailController, 'Email'),
                const SizedBox(height: 16),
                _buildTextField(_cityController, 'Ville'),
                const SizedBox(height: 16),
                _buildDropdownField('Sexe', selectedGender, ['Homme', 'Femme', 'Autre']),
                const SizedBox(height: 16),
                _buildCountryPicker(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ce champ est requis';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> options) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: options
          .map((option) => DropdownMenuItem(
        value: option,
        child: Text(option),
      ))
          .toList(),
      onChanged: (newValue) {
        setState(() {
          selectedGender = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez sélectionner une option';
        }
        return null;
      },
    );
  }

  Widget _buildCountryPicker() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Pays',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
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
      controller: TextEditingController(text: selectedCountry),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez sélectionner un pays';
        }
        return null;
      },
    );
  }
}
