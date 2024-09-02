import 'package:chat/core/models/chat_notification.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  List<ChatNotification> get item => [..._items];

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i){
    _items.removeAt(i);
    notifyListeners();
  }
}
