import 'package:flutter/material.dart';

class TermsAndPolicyPage extends StatelessWidget {
  const TermsAndPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Termes et Politiques de Sécurité"),
        backgroundColor: const Color(0xFFD32F2F), // Rouge bordeaux
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Termes et Conditions",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "En utilisant notre application, vous acceptez les termes suivants :\n\n"
                  "1. Vous ne devez pas utiliser l'application pour des activités illégales.\n"
                  "2. Vous devez respecter les droits des autres utilisateurs et ne pas diffuser de contenu offensant.\n"
                  "3. Vous êtes responsable de la confidentialité de vos identifiants de connexion.\n"
                  "4. L'utilisation de nos services est à vos propres risques.\n"
                  "5. Nous nous réservons le droit de suspendre votre compte en cas de violation des termes.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              "Politique de Confidentialité",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Nous respectons votre vie privée et nous nous engageons à protéger vos données personnelles :\n\n"
                  "1. Nous recueillons uniquement les informations nécessaires à l'utilisation de l'application.\n"
                  "2. Vos informations ne seront jamais partagées avec des tiers sans votre consentement.\n"
                  "3. Vous avez le droit de modifier ou supprimer vos données personnelles à tout moment.\n"
                  "4. Nous utilisons des mesures de sécurité pour protéger vos données contre tout accès non autorisé.\n"
                  "5. Vous acceptez que certaines données anonymisées puissent être utilisées à des fins statistiques.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              "Conditions Générales",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "1. L'application est fournie en l'état, sans garantie d'aucune sorte.\n"
                  "2. Nous nous réservons le droit de modifier les conditions d'utilisation à tout moment.\n"
                  "3. Vous acceptez d'utiliser l'application conformément aux lois applicables dans votre pays.\n"
                  "4. Toute violation des conditions peut entraîner la résiliation immédiate de votre compte.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Ferme la page
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: const Color(0xFFD32F2F), // Rouge bordeaux
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "J'accepte",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
