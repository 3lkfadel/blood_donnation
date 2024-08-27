import 'package:blood_donnation/firebase_options.dart';
import 'package:blood_donnation/page/ConnexionPage/LoginPage.dart';
import 'package:blood_donnation/page/ConnexionPage/SiginUppage.dart';
import 'package:blood_donnation/page/ConnexionPage/GroupeSelectionpage.dart';
import 'package:blood_donnation/page/Learningpage/LearningPage2.dart';
import 'package:blood_donnation/page/animation/PageView.dart';
import 'package:blood_donnation/page/learningpage/LearningPage1.dart';
import 'package:blood_donnation/page/learningpage/learningpage3.dart';
import 'package:blood_donnation/page/map/map.dart';
import 'package:blood_donnation/page/menue/DemanderInformation.dart';
import 'package:blood_donnation/page/menue/HomePage.dart';
import 'package:blood_donnation/page/menue/NotificationPage.dart';
import 'package:blood_donnation/page/menue/ProfilePage.dart';
import 'package:blood_donnation/page/menue/UserDons.dart';
import 'package:blood_donnation/page/menue/AnnoncePage.dart';
import 'package:blood_donnation/page/menue/DemandePage.dart';
import 'package:blood_donnation/page/menue/Details.dart';
import 'package:blood_donnation/page/menue/Historique.dart';
import 'package:blood_donnation/page/menue/SettingPage.dart';
import 'package:blood_donnation/page/restePassword/ResetPage1.dart';
import 'package:blood_donnation/page/restePassword/resetPage2.dart';
import 'package:blood_donnation/page/restePassword/resetPassword3.dart';
import 'package:blood_donnation/page/root/navroot.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:blood_donnation/config/firebase_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/leraningpage': (context) => Learningpage1(),
        '/leraningpage2': (context) => Learningpage2(),
        '/leraningpage3': (context) => Learningpage3(),
        '/login': (context) => LoginPage(),
        '/siginup': (context) => Siginuppage(),
        '/reset': (context) => Resetpage(),
          '/reset2': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
            return VerificationPage(email: args['email']!);
          },
          '/reset3': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
            return Resetpassword3(email: args['email']!);
          },

        '/selectionsang': (context) => BloodGroupSelectionScreen(),
        '/homepage': (context) => HomePage(),
        '/demande': (context) => BloodDonationFormPage(),
        '/annonce': (context) => Annoncepage(),
        '/NotificationPage': (context) => NotificationPage(),
        '/nav': (context) => Navroot(),
        '/ProfilePage': (context) => ProfilePage(),
        '/historique' : (context)=>Historique(),
        '/map':(context)=> MapScreen(),
        '/details': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
          final notificationId = args['notificationId'] as int?;
          final annonceId = args['annonceId'] as int?;

          return Details(notificationId: notificationId, annonceId: annonceId);
        },


        '/DemanderInformation' : (context) => DemanderInformation()

      },
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
