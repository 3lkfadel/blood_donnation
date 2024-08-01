import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'NOTIFI', style: TextStyle(color: Colors.black)),
              TextSpan(text: 'CATION', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Gérer l'icône de notification
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            NotificationTile(
              title: 'Titre de la notification 1',
              content: 'Contenue de la notification 1',
              isRead: true,
            ),
            NotificationTile(
              title: 'Titre de la notification 2',
              content: 'Contenue de la notification 2',
              isRead: false,
            ),
            NotificationTile(
              title: 'Titre de la notification 3',
              content: 'Contenue de la notification 3',
              isRead: true,
            ),
            NotificationTile(
              title: 'Titre de la notification 4',
              content: 'Contenue de la notification 4',
              isRead: false,
            ),
            NotificationTile(
              title: 'Titre de la notification 5',
              content: 'Contenue de la notification 5',
              isRead: true,
            ),
            NotificationTile(
              title: 'Titre de la notification 6',
              content: 'Contenue de la notification 6',
              isRead: false,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String content;
  final bool isRead;

  NotificationTile({
    required this.title,
    required this.content,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.notifications),
        title: Text(
          title,
          style: TextStyle(
            decoration: isRead ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(content),
        trailing: Icon(
          Icons.circle,
          color: isRead ? Colors.blue : Colors.red,
          size: 16,
        ),
      ),
    );
  }
}
