import 'package:blood_donnation/page/menue/FeedPage.dart';
import 'package:blood_donnation/page/menue/HomePage.dart';
import 'package:blood_donnation/page/menue/AnnoncePage.dart';
import 'package:blood_donnation/page/menue/SettingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Navroot extends StatefulWidget {
  const Navroot({super.key});

  @override
  State<Navroot> createState() => _NavrootState();
}

class _NavrootState extends State<Navroot> {
  int _selectIndex = 0;
  final _screens = [
    HomePage(),
    // FeedPage(),
    Annoncepage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Coins arrondis
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 4), // Ombre vers le bas
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Assure que la barre de navigation respecte les coins arrondis
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent, // Fond transparent pour montrer le Container parent
              elevation: 0, // Supprime l'élévation par défaut
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xFF7165D6),
              unselectedItemColor: Colors.black,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              currentIndex: _selectIndex,
              onTap: (index) {
                setState(() {
                  _selectIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "",
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(CupertinoIcons.chat_bubble),
                //   label: "",
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
