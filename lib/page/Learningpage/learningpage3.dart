import 'package:flutter/material.dart';

class Learningpage3 extends StatelessWidget {
  const Learningpage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        color: Colors.white, // Ajoutez cette ligne pour définir la couleur de fond
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
                  "À Qui S'Adresse Don Don Vital ?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Don Don Vital s'adresse à tous ceux qui veulent contribuer à sauver des vies. Que vous soyez un donneur de sang régulier, un nouveau donneur souhaitant faire une différence, ou une personne ayant besoin de sang, notre application est faite pour vous. Ensemble, nous pouvons faire une réelle différence dans la vie de nombreuses personnes.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20), 
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: (){
                       Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 218, 56, 27), 
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text("Next"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
