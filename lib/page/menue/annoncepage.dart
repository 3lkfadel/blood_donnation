import 'package:flutter/material.dart';

class Annoncepage extends StatefulWidget {
   Annoncepage({super.key});

  @override
  State<Annoncepage> createState() => _AnnoncepageState();
}

class _AnnoncepageState extends State<Annoncepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'TI',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'TLE',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/demande');
                     
                    },
                    icon: Icon(Icons.bloodtype),
                    label: Text('I need blood'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.favorite),
                    label: Text('Blood center'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(onPressed: (){}, child: Text("repondre")),
                        
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/image.png'), // Assurez-vous d'avoir une image dans assets
                ),
                title: Text('Koloma fadel'),
                subtitle: Text('Rue 24 Bobo'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('B+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.red),
                        SizedBox(width: 4),
                        Icon(Icons.message, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            
          ],
        ),
      ),
    );
  }
}
