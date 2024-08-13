import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    "assets/learningpage/image3.png",
    "assets/learningpage/image2.png",
    "assets/learningpage/image3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/Icons/Icon.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/NotificationPage');
            },
            icon: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Set the background color of the entire Scaffold
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: imgList.map((item) => Container(
                  child: Center(
                    child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                  ),
                )).toList(),
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildClickableElement(Icons.person, "Voir Mon Profil", '/ProfilePage'),
                    _buildClickableElement(Icons.add_circle_outline, "Publier Annonce", '/demande'),
                    _buildClickableElement(Icons.visibility, "Voir Annonce", '/Annoncepage'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                "ANNONCE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 15),
              Card(
                color: Colors.red[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Text(
                    'B+', 
                    style: TextStyle(
                      color: Colors.red, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text('Koloma Fadel'),
                  subtitle: Text('Rue 24 Bobo'),
                  trailing: TextButton(
                    onPressed: (){},
                    child: Text("Répondre"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClickableElement(IconData icon, String text, String routeName) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(121, 239, 19, 19),
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), 
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Column(
          children: [
            Icon(icon, size: 40, color: Color(0x80FFFFFF)),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
