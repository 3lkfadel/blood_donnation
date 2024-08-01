import 'package:flutter/material.dart';

class Learningpage1 extends StatelessWidget {
  const Learningpage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.all(20),
              child: ClipRRect(
                
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "name",
                  height: 200,
                ),
              ),
            ),
            
            SizedBox(height: 50,),
            Text(
              "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Magni impedit perferendis quaerat repellat laborum amet earum assumenda accusamus! Dolorum rem at aliquid, consequatur accusantium eius possimus suscipit sunt fuga necessitatibus?",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
