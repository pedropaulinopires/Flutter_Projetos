import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas notificações'),
      ),
      body: SafeArea(
        child: Consumer<ChatNotificationService>(
          builder: (ctx, providerNotification, child) => Center(
            child: ListView.builder(
              itemCount: providerNotification.item.length,
              itemBuilder: (ctx2, index) => ListTile(
                title: Text(providerNotification.item[index].title),
                subtitle: Text(providerNotification.item[index].body),
                onTap: () => providerNotification.remove(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
