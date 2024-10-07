import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:blood_donnation/api.dart';
import '../menue/FeedPage.dart';

class Siginuppage extends StatefulWidget {
  const Siginuppage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<Siginuppage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  String? _errorMessage;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isTermsAccepted = false; // Ajout pour l'acceptation des termes

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate() || !_isTermsAccepted) {
      setState(() {
        _errorMessage = !_isTermsAccepted
            ? 'Vous devez accepter les termes et conditions pour vous inscrire.'
            : null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await apiService.register(
        _fullNameController.text,
        _emailController.text,
        _phoneController.text,
        _passwordController.text,
        _confirmPasswordController.text,
      );

      if (response.statusCode == 201) {
        final responseData = response.data;
        if (responseData != null && responseData['token'] != null) {
          await apiService.storeToken(responseData['token']);
          Navigator.pushReplacementNamed(context, '/selectionsang');
        } else {
          setState(() {
            _errorMessage = 'Token non trouvé dans la réponse d\'inscription.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Échec de l\'inscription. Code: ${response.statusCode}';
        });
      }
    } catch (e) {
      String errorMessage;
      if (e is DioError) {
        if (e.response != null && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? 'Échec de l\'inscription.';
        } else {
          errorMessage = 'Erreur réseau. Veuillez réessayer.';
        }
      } else {
        errorMessage = 'Une erreur inattendue s\'est produite.';
      }
      setState(() {
        _errorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
      child: SingleChildScrollView(
      child: ConstrainedBox(
      constraints: const BoxConstraints(
      maxWidth: 350,
    ),
    child: Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 5,
    blurRadius: 15,
    offset: const Offset(0, 3),
    ),
    ],
    ),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    const Text(
    "S'inscrire",
    style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    letterSpacing: 1.2,
    ),
    ),
    const SizedBox(height: 20),
    if (_errorMessage != null)
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Text(
    _errorMessage!,
    style: const TextStyle(color: Colors.red),
    ),
    ),
    const SizedBox(height: 10),
    Form(
    key: _formKey,
    child: Column(
    children: <Widget>[
    TextFormField(
    controller: _fullNameController,
    decoration: InputDecoration(
    labelText: 'Nom complet',
    prefixIcon: const Icon(Icons.person, color: Color(0xFFB71C1C)),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Le nom complet est obligatoire';
    }
    return null;
    },
    ),
    const SizedBox(height: 15),
    TextFormField(
    controller: _emailController,
    decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: const Icon(Icons.email, color: Color(0xFFB71C1C)),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'L\'email est obligatoire';
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Veuillez entrer un email valide';
        }
        return null;
      },
    ),
      const SizedBox(height: 15),
      TextFormField(
        controller: _phoneController,
        decoration: InputDecoration(
          labelText: 'Numéro de téléphone',
          prefixIcon: const Icon(Icons.phone, color: Color(0xFFB71C1C)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le numéro de téléphone est obligatoire';
          }
          return null;
        },
      ),
      const SizedBox(height: 15),
      TextFormField(
        controller: _passwordController,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          labelText: 'Mot de passe',
          prefixIcon: const Icon(Icons.lock, color: Color(0xFFB71C1C)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFFB71C1C),
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le mot de passe est obligatoire';
          } else if (value.length < 6) {
            return 'Le mot de passe doit contenir au moins 6 caractères';
          }
          return null;
        },
      ),
      const SizedBox(height: 15),
      TextFormField(
        controller: _confirmPasswordController,
        obscureText: !_confirmPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Confirmer le mot de passe',
          prefixIcon: const Icon(Icons.lock, color: Color(0xFFB71C1C)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFFB71C1C),
            ),
            onPressed: () {
              setState(() {
                _confirmPasswordVisible = !_confirmPasswordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value != _passwordController.text) {
            return 'Les mots de passe ne correspondent pas';
          }
          return null;
        },
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Checkbox(
            value: _isTermsAccepted,
            activeColor: const Color(0xFFB71C1C),
            onChanged: (bool? value) {
              setState(() {
                _isTermsAccepted = value ?? false;
              });
            },
          ),
          const Text('J\'accepte les '),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsAndPolicyPage(),
                ),
              );
            },
            child: const Text(
              'termes et conditions',
              style: TextStyle(
                color: Color(0xFFB71C1C),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: _isLoading ? null : _register,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          backgroundColor: const Color(0xFFB71C1C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : const Text(
          'S\'inscrire',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      const SizedBox(height: 10),
      if (_errorMessage != null)
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
    ],
    ),
    ),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Vous avez déjà un compte ? Se connecter',
          style: TextStyle(
            color: Color(0xFF1C4DB7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
    ),
    ),
      ),
      ),
      ),
    );
  }
}

