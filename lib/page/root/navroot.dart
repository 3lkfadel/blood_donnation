import 'package:blood_donnation/page/menue/FeedPage.dart';
import 'package:blood_donnation/page/menue/HomePage.dart';
import 'package:blood_donnation/page/menue/annoncepage.dart';
import 'package:blood_donnation/page/menue/settingpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Navroot extends StatefulWidget {
  const Navroot({super.key});

  @override
  State<Navroot> createState() => _NavrootState();
}

class _NavrootState extends State<Navroot> {
   int _selectIndex = 0;
   final _screens =  [
    HomePage(),
    // FeedPage(),
    Annoncepage(),
    SettingPage(),


  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectIndex],
     bottomNavigationBar: Container(
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(  // effet d'ombre 
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 7,
        offset: Offset(0, -3), // direction de l'ombre 
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.only( 
      topLeft: Radius.circular(20), 
      topRight: Radius.circular(20), 
       ),
       child: BottomNavigationBar(
      backgroundColor: Colors.white,
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
    );
  }
}