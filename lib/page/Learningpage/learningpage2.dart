import 'package:flutter/material.dart';

class Learningpage2 extends StatelessWidget {
  const Learningpage2({super.key});


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
                  "assets/learningpage/image2.png",
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  " Pourquoi Don Don Vital ?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Don Don Vital a été créé pour répondre à un besoin crucial : simplifier le processus de don de sang. Notre application permet de mettre en relation directe les donneurs et les receveurs, assurant ainsi une réponse rapide et efficace aux urgences et aux besoins continus de sang. Nous visons à créer une communauté solidaire et réactive.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20), 
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: (){
                       Navigator.pushNamed(context, '/leraningpage3');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, 
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
