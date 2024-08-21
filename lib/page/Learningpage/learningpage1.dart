import 'package:flutter/material.dart';

class Learningpage1 extends StatelessWidget {
  const Learningpage1({super.key});


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/learningpage/image3.png",
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bienvenue sur Don Don Vital",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Bienvenue sur Don Don Vital, l'application dédiée à la facilitation du don de sang. Grâce à notre plateforme, vous pouvez facilement connecter les donneurs et les receveurs de sang. Que vous soyez un donneur souhaitant sauver des vies ou une personne en quête de sang, Don Don Vital est là pour vous.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify, // Justifier le texte pour une répartition uniforme
                ),
                SizedBox(height: 20), // Espace entre le texte et le bouton
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
