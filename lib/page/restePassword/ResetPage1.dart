import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:blood_donnation/api.dart';

class Resetpage extends StatefulWidget {
  const Resetpage({super.key});

  @override
  _ResetpageState createState() => _ResetpageState();
}

class _ResetpageState extends State<Resetpage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    String email = _emailController.text;

    if (email.isEmpty || !EmailValidator.validate(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez entrer un email valide.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ApiService().sendResetPasswordLink(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email de réinitialisation envoyé.')),
      );
      // Passez l'email lors de la navigation vers la page de vérification
      Navigator.pushNamed(
        context,
        '/reset2',
        arguments: {'email': email},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 7),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Réinitialiser le mot de passe",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text("Veuillez entrer votre email pour recevoir un lien de réinitialisation."),
              SizedBox(height: 15),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _resetPassword,
                child: Text("Suivant"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF5C9CEF),
    );
  }
}
