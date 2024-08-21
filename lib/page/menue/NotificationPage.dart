import 'package:blood_donnation/config/Notification.dart';
import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';
import 'Details.dart';

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
                  annonceId: notification.annonceId,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class NotificationTile extends StatefulWidget {
  final String title;
  final String content;
  final bool isRead;
  final int notificationId;
  final int annonceId;

  const NotificationTile({
    Key? key,
    required this.title,
    required this.content,
    required this.isRead,
    required this.notificationId,
    required this.annonceId,
  }) : super(key: key);

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  final ApiService _apiService = ApiService();
  String? _userId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final profileData = await _apiService.getProfiles();
      setState(() {
        _userId = profileData['id'].toString();
      });
    } catch (e) {
      print('Erreur lors de la récupération du profil : $e');
    }
  }

  Future<void> _handleTileTap() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: Impossible de récupérer votre profil.')),
      );
      return;
    }

    // Vérifier si la notification est déjà lue
    if (!widget.isRead) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Créer le don uniquement si la notification n'est pas encore lue
        await _apiService.createDon(widget.annonceId, _userId!);

        // Marquer la notification comme lue dans l'API
        await _apiService.markNotificationAsRead(widget.notificationId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Demande envoyée avec succès.')),
        );
      } catch (e) {
        print('Erreur: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'envoi de la demande.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    // Ouvrir la page de détails (peu importe si la notification est lue ou non)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Details(notificationId: widget.notificationId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isLoading ? null : _handleTileTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: _isLoading
              ? CircularProgressIndicator()
              : Icon(Icons.notifications),
          title: Text(
            widget.title,
            style: TextStyle(
              decoration: widget.isRead ? TextDecoration.lineThrough : null,
              color: widget.isRead ? Colors.grey : Colors.black,
            ),
          ),
          subtitle: Text(
            widget.content,
            style: TextStyle(color: widget.isRead ? Colors.grey : Colors.black),
          ),
          trailing: Icon(
            Icons.circle,
            color: widget.isRead ? Colors.blue : Colors.red,
            size: 16,
          ),
        ),
      ),
    );
  }
}
