import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:blood_donnation/config/config.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FirebaseApi {
  // une instance de Firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialisation de FirebaseMessaging
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    //obtenir le token fcm pour cet appareil
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');



    initPushNotifications();

  }

  // gerer les notifications push
  void handleMessage (RemoteMessage? message) {
    if (message!= null) {
      print('From: ${message.from}');
      print('Message: ${message.notification?.body}');
    }
    // naviguer vers la page de notification lorsque l'utilisateur tape sur la notification
    navigatorKey.currentState?.pushNamed(
      '/notification',
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }


}