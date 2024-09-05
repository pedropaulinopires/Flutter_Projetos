import 'package:chat/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  List<ChatNotification> get item => [..._items];

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  //push notification
  Future<void> init() async {
    await _configureForegorund();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForegorund() async {
    if (await _isAuthorized == true) {
      FirebaseMessaging.onMessage.listen((msg) {
        if (msg.notification == null) return;

        add(ChatNotification(
          title: msg.notification!.title ?? "Não informado",
          body: msg.notification!.body ?? "Não informado",
        ));
      });
    }
  }
}
