import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Every device joins the "announcements" topic. A new post sends one
/// message to that topic (see functions/index.js).
class NotificationService {
  static Future<void> init(GlobalKey<ScaffoldMessengerState> messengerKey) async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();

      if (!kIsWeb) await messaging.subscribeToTopic('announcements');

      FirebaseMessaging.onMessage.listen((message) {
        final n = message.notification;
        if (n == null) return;
        messengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('${n.title ?? 'New announcement'}')),
        );
      });
    } catch (e) {
      debugPrint('Notification setup failed: $e');
    }
  }
}
