import 'package:flutter/material.dart';

class setingpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
       title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'D',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: AutofillHints.addressCity,
                  fontSize: 50,
                ),
              ),
              TextSpan(
                text: 'on',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'vital',
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
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/avatar.png'), // Replace with your image
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GRACE',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'KOLOMA',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Card(
                color: Colors.red[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Group blood'),
                          Text('donation'),
                          Text('Gender'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Blood point'),
                          Text('Gender'),
                          Text('Gender'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/DonationHistoryPage');
      },
      child: _buildFeatureCard('Donation history', Icons.history, Colors.lightBlue[100]),
    ),
    InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/ProfilePage');
      },
      child: _buildFeatureCard('Edit my profile', Icons.edit, Colors.lightBlue[200]),
    ),
  ],
),
SizedBox(height: 16),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/BloodPointPage');
      },
      child: _buildFeatureCard('Blood point', Icons.bloodtype, Colors.red[100]),
    ),
    InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/MyPostPage');
      },
      child: _buildFeatureCard('My post', Icons.post_add, Colors.green[100]),
    ),
  ],
),

            ],
          ),
        ),
      ),
      
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Color? color) {
    return Expanded(
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.black54),
              SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
