import 'package:flutter/material.dart';

class  Resetpage extends StatelessWidget {
  const Resetpage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Reset password",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 15,),
              Text("Texte explicatif de se qui l’utilisateur doit faire  "),
              SizedBox(height: 15,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, '/reset2');
              }, child: Text("next"),
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