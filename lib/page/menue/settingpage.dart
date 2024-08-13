import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';

class SettingPage extends StatelessWidget {
  final ApiService _apiService = ApiService();

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
        automaticallyImplyLeading: false, 
      ),
      body: FutureBuilder(
        future: _apiService.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data?.data; // Accéder aux données
            final imageUrl = data['image'] as String?;
            final name = data['name'] as String?;
            final email = data['email'] as String?;
            final phone = data['telephone'] as String?;
            final gender = data['sexe'] as String?;
            final groupesanguin = data['blood_group'] as String?;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : AssetImage('assets/avatar.png') as ImageProvider, // Image par défaut si imageUrl est null
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name ?? 'No name',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              email ?? 'No email',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            Text(
                              phone ?? 'No phone',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            Text(
                              gender ?? 'No gender',
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
                                Text('Groupe sanguin'),
                                Text( groupesanguin ?? '' ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Blood point'),
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
                            Navigator.pushNamed(context, '/historique');
                          },
                          child: _buildFeatureCard(' Histororique', Icons.history, Colors.lightBlue[100]),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/ProfilePage');
                          },
                          child: _buildFeatureCard('Editer profil', Icons.edit, Colors.lightBlue[200]),
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
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
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
