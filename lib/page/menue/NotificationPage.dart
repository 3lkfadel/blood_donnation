import 'package:blood_donnation/config/Notification.dart';
import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';

import 'details.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<AppNotification>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = ApiService().getNotifications();
  }

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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<AppNotification>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune notification disponible'));
          } else {
            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationTile(
                  title: notification.titre,
                  content: notification.message,
                  isRead: notification.isRead,
                  notificationId: notification.id,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String content;
  final bool isRead;
  final int notificationId;

  const NotificationTile({
    super.key,
    required this.title,
    required this.content,
    required this.isRead,
    required this.notificationId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(notificationId: notificationId),
          ),
        );
      },
      child: Card(
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
      ),
    );
  }
}
