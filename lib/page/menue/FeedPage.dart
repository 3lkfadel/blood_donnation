import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> postsData = [
      {
        'avatarImagePath': 'assets/avatar1.png',
        'userName': 'User One',
        'timeAgo': '2 mins ago',
        'postTitle': 'First Post Title',
        'postImagePath': 'assets/post_image1.png',
        'postContent': 'This is the content of the first post.',
      },
      {
        'avatarImagePath': 'assets/avatar2.png',
        'userName': 'User Two',
        'timeAgo': '10 mins ago',
        'postTitle': 'Second Post Title',
        'postImagePath': 'assets/post_image2.png',
        'postContent': 'This is the content of the second post.',
      },
      {
        'avatarImagePath': 'assets/avatar3.png',
        'userName': 'User Three',
        'timeAgo': '1 hour ago',
        'postTitle': 'Third Post Title',
        'postImagePath': 'assets/post_image3.png',
        'postContent': 'This is the content of the third post.',
      },
    ];

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
                    text: 'FE',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'ED',
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
        child: Column(
          children: postsData.map((postData) {
            return PostWidget(
              avatarImagePath: postData['avatarImagePath']!,
              userName: postData['userName']!,
              timeAgo: postData['timeAgo']!,
              postTitle: postData['postTitle']!,
              postImagePath: postData['postImagePath']!,
              postContent: postData['postContent']!,
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String avatarImagePath;
  final String userName;
  final String timeAgo;
  final String postTitle;
  final String postImagePath;
  final String postContent;

  PostWidget({
    required this.avatarImagePath,
    required this.userName,
    required this.timeAgo,
    required this.postTitle,
    required this.postImagePath,
    required this.postContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(avatarImagePath),
              ),
              title: Text(userName),
              subtitle: Text(timeAgo),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                postTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(postImagePath),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(postContent),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
