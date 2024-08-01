import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
               Navigator.pushNamed(context, '/NotificationPage');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PageView(
                  children: [
                    Image.asset('name', fit: BoxFit.cover),
                   
                  ],
                ),
              ),
              SizedBox(height: 16),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey[300],
                  );
                },
                itemCount: 4,
              ),
              SizedBox(height: 16),
              Card(
                color: Colors.red[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('name'),
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
              Card(
                color: Colors.red[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('name'),
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
              Card(
  color: Colors.red[50],
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: ListTile(
    leading: CircleAvatar(
      backgroundImage: AssetImage('name'),
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
            GestureDetector(
              onTap: () {
                print('Icône téléphone cliquée');
              },
              child: Icon(Icons.phone, color: Colors.red),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                print('Icône message cliquée');
              },
              child: Icon(Icons.message, color: Colors.red),
            ),
          ],
        ),
      ],
    ),
  ),
),

            ],
          ),
        ),
      ),
     
    );
  }
}