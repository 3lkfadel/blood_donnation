import 'package:flutter/material.dart';

class Learningpage2 extends StatelessWidget {
  const Learningpage2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            Padding(padding: EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
             child: Image.asset("name",
             height: 200,
             ),
            ),
            ),
            SizedBox(height: 50,),
            Text("data",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
            
            )
          ],
        ),
      ),
    );
  }
}