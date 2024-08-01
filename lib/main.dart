import 'package:blood_donnation/page/ConnexionPage/LoginPage.dart';
import 'package:blood_donnation/page/ConnexionPage/SiginUppage.dart';
import 'package:blood_donnation/page/ConnexionPage/groupeselectionpage.dart';
import 'package:blood_donnation/page/Learningpage/learningpage2.dart';
import 'package:blood_donnation/page/learningpage/LearningPage1.dart';
import 'package:blood_donnation/page/learningpage/learningpage3.dart';
import 'package:blood_donnation/page/menue/HomePage.dart';
import 'package:blood_donnation/page/menue/NotificationPage.dart';
import 'package:blood_donnation/page/menue/ProfilePage.dart';
import 'package:blood_donnation/page/menue/demandePage.dart';
import 'package:blood_donnation/page/menue/settingpage.dart';
import 'package:blood_donnation/page/restePassword/ResetPage1.dart';
import 'package:blood_donnation/page/restePassword/resetPage2.dart';
import 'package:blood_donnation/page/restePassword/resetPassword3.dart';
import 'package:blood_donnation/page/root/navroot.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
         '/leraningpage' : (context) => Learningpage1(),
         '/leraningpage2' : (context) => Learningpage2(),
         '/leraningpage3' : (context) => Learningpage3(),
        '/login' : (context) => Loginpage(),
         '/siginup' : (context) => Siginuppage(),
          '/reset' : (context) => Resetpage(),
          '/reset2' : (context) => VerificationPage(),
          '/reset3' : (context) => Resetpassword3(),
          '/selectionsang' : (context)=> BloodGroupSelectionScreen(),
          '/homepage': (context) => HomePage(),
          '/demande': (context) => BloodDonationFormPage(),
          '/NotificationPage': (context) => NotificationPage(),
          '/nav':(context) => Navroot(),
          '/ProfilePage': (context) => ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
      home: Loginpage(),

    );
      
  }
}
