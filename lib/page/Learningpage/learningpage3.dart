import 'package:flutter/material.dart';

class Learningpage3 extends StatelessWidget {
  const Learningpage3({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("name",
              height: 200,
              ),
            ),
            ),
            SizedBox(height: 50,),
            Text("data",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            )
          ],
        ),
      ),
    );
  }
}